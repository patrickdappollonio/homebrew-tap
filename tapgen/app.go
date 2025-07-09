package tapgen

import (
	"context"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/github"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/template"
	"github.com/spf13/cobra"
)

// Run executes the tapgen command-line application.
func Run() error {
	var configLocation, targetPackage, readmeTemplate string
	var cleanupOrphaned bool

	cmd := &cobra.Command{
		Use:           os.Args[0],
		SilenceUsage:  true,
		SilenceErrors: true,
		Short:         "Generate Homebrew formulas for GitHub releases based off a config file.",
		RunE: func(cmd *cobra.Command, args []string) error {
			return execute(configLocation, targetPackage, readmeTemplate, cleanupOrphaned)
		},
	}

	cmd.Flags().StringVarP(&configLocation, "config", "c", "config.yaml", "Location of the configuration file to use")
	cmd.Flags().StringVarP(&targetPackage, "target", "t", "", "Only generate the formula for the specified package target as specified in the config file's \"name\" field")
	cmd.Flags().StringVarP(&readmeTemplate, "readme-template", "r", "readme.md.gotmpl", "Path to the README template file")
	cmd.Flags().BoolVar(&cleanupOrphaned, "cleanup-orphaned", false, "Remove formula files that no longer correspond to apps in the config")

	return cmd.Execute()
}

// execute runs the main application logic.
func execute(configLocation, targetPackage, readmeTemplate string, cleanupOrphaned bool) error {
	configs, err := cfg.ParseConfig(configLocation)
	if err != nil {
		return fmt.Errorf("failed to parse config: %w", err)
	}

	formulas, err := filterConfigs(configs, targetPackage)
	if err != nil {
		return err
	}

	log.Printf("Found %d formulas to generate", len(formulas))

	ctx := context.Background()
	token := getGitHubToken()

	if err := generateFormulas(ctx, token, formulas); err != nil {
		return err
	}

	// Clean up any orphaned formula files only if requested
	if cleanupOrphaned {
		if err := cleanupOrphanedFormulas(configs); err != nil {
			log.Printf("Warning: failed to cleanup orphaned formulas: %v", err)
		}
	}

	return generateReadme(configs, readmeTemplate)
}

// filterConfigs returns the subset of configs to process based on the target package.
func filterConfigs(configs []cfg.Config, targetPackage string) ([]cfg.Config, error) {
	if targetPackage == "" {
		return configs, nil
	}

	for _, config := range configs {
		if config.Name == targetPackage {
			return []cfg.Config{config}, nil
		}
	}

	return nil, fmt.Errorf("package %q not found in configuration", targetPackage)
}

// generateFormulas generates Homebrew formula files for the given configs.
func generateFormulas(ctx context.Context, token string, formulas []cfg.Config) error {
	for _, config := range formulas {
		if err := generateSingleFormula(ctx, token, config); err != nil {
			return err
		}
	}
	return nil
}

// sortDownloads sorts downloads to ensure deterministic output in the generated formula files.
// Downloads are sorted by:
// 1. Platform (MacOS first, then Linux)
// 2. Architecture (platform-specific priorities):
//   - MacOS: ARM64 first, then Intel, then ARM
//   - Linux: Intel first, then ARM64, then ARM
//
// 3. Filename (alphabetically for deterministic ordering)
func sortDownloads(downloads []github.Download) {
	sort.Slice(downloads, func(i, j int) bool {
		a, b := downloads[i], downloads[j]

		// First, sort by platform (MacOS first, then Linux)
		if a.IsMacOS() && !b.IsMacOS() {
			return true
		}
		if !a.IsMacOS() && b.IsMacOS() {
			return false
		}

		// Within the same platform, sort by architecture with platform-specific priorities
		aArch := getArchitecturePriority(a)
		bArch := getArchitecturePriority(b)
		if aArch != bArch {
			return aArch < bArch
		}

		// Finally, sort by filename for deterministic ordering
		return a.Filename < b.Filename
	})
}

// getArchitecturePriority returns a numeric priority for architecture sorting.
// Lower numbers have higher priority.
// MacOS: ARM64 first, then Intel, then ARM
// Linux: Intel first, then ARM64, then ARM
func getArchitecturePriority(download github.Download) int {
	if download.IsMacOS() {
		// MacOS architecture priorities: ARM64 first
		if download.IsARM64() {
			return 1
		}
		if download.IsIntel() {
			return 2
		}
		if download.IsARM() {
			return 3
		}
		return 4 // Unknown architecture
	} else {
		// Linux architecture priorities: Intel first
		if download.IsIntel() {
			return 1
		}
		if download.IsARM64() {
			return 2
		}
		if download.IsARM() {
			return 3
		}
		return 4 // Unknown architecture
	}
}

// generateSingleFormula generates a single Homebrew formula file.
func generateSingleFormula(ctx context.Context, token string, config cfg.Config) error {
	formulaFile := filepath.Join("Formula", fmt.Sprintf("%s.rb", strings.ToLower(config.Name)))

	// Try to parse existing cache
	existingCache, err := github.ParseCacheFromFormula(formulaFile)
	if err != nil {
		log.Printf("Warning: failed to parse cache from %s: %v", formulaFile, err)
		existingCache = nil
	}

	log.Printf("Fetching latest download for %q (repo: %q)", config.Name, config.Repository)

	tag, downloads, newCache, err := github.GetLatestDownloadsWithCache(ctx, token, config.Repository, existingCache)
	if err != nil {
		return fmt.Errorf("failed to get latest download for %q: %w", config.Name, err)
	}

	log.Printf("Found %d downloads for %q (version: %s); generating formula file: %s", len(downloads), config.Name, tag, formulaFile)

	// Sort downloads to ensure deterministic output
	sortDownloads(downloads)

	newFormula, err := template.GenerateFormula(config, tag, downloads, newCache)
	if err != nil {
		return fmt.Errorf("failed to generate formula: %w", err)
	}

	return writeFormulaFile(formulaFile, newFormula)
}

// writeFormulaFile writes the formula content to a file, but only if it has changed.
func writeFormulaFile(filename, content string) error {
	currentContent, err := readFileIfExists(filename)
	if err != nil {
		return fmt.Errorf("failed to read existing formula file: %w", err)
	}

	if currentContent == content {
		log.Printf("Formula file %q is up to date, skipping...", filename)
		return nil
	}

	if err := os.WriteFile(filename, []byte(content), 0o644); err != nil {
		return fmt.Errorf("failed to write formula file: %w", err)
	}

	log.Printf("Formula file %q generated successfully", filename)
	return nil
}

// readFileIfExists reads a file if it exists, otherwise returns an empty string.
func readFileIfExists(filename string) (string, error) {
	content, err := os.ReadFile(filename)
	if os.IsNotExist(err) {
		return "", nil
	}
	if err != nil {
		return "", err
	}
	return string(content), nil
}

// generateReadme generates the README file for all formulas.
func generateReadme(configs []cfg.Config, templatePath string) error {
	log.Printf("Generating README file for %d formulas using template: %s", len(configs), templatePath)

	content, err := template.GenerateReadme(configs, templatePath)
	if err != nil {
		return fmt.Errorf("failed to generate README file: %w", err)
	}

	if err := os.WriteFile("README.md", []byte(content), 0o644); err != nil {
		return fmt.Errorf("failed to write README file: %w", err)
	}

	log.Println("README file generated successfully")
	return nil
}

// getGitHubToken retrieves the GitHub token from environment variables.
func getGitHubToken() string {
	return strings.TrimSpace(os.Getenv("GITHUB_TOKEN"))
}

// cleanupOrphanedFormulas removes formula files that no longer correspond to apps in the config.
func cleanupOrphanedFormulas(configs []cfg.Config) error {
	// Create a set of expected formula files
	expectedFiles := make(map[string]bool)
	for _, config := range configs {
		formulaFile := fmt.Sprintf("%s.rb", strings.ToLower(config.Name))
		expectedFiles[formulaFile] = true
	}

	// Read the Formula directory
	entries, err := os.ReadDir("Formula")
	if err != nil {
		if os.IsNotExist(err) {
			// Formula directory doesn't exist, nothing to clean up
			return nil
		}
		return fmt.Errorf("failed to read Formula directory: %w", err)
	}

	// Check each .rb file
	for _, entry := range entries {
		if entry.IsDir() || !strings.HasSuffix(entry.Name(), ".rb") {
			continue
		}

		if !expectedFiles[entry.Name()] {
			formulaPath := filepath.Join("Formula", entry.Name())
			log.Printf("Removing orphaned formula file: %s", formulaPath)
			if err := os.Remove(formulaPath); err != nil {
				return fmt.Errorf("failed to remove orphaned formula %q: %w", formulaPath, err)
			}
		}
	}

	return nil
}

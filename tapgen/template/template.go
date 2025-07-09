// Package template provides functionality for generating Homebrew formulas and README files.
package template

import (
	"bytes"
	"embed"
	"fmt"
	"os"
	"strings"
	"text/template"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/github"
)

var (
	//go:embed *.gotmpl
	files embed.FS

	// compiled is the pre-compiled template containing all formula templates.
	compiled *template.Template
)

// FormulaPayload represents the data structure passed to formula templates.
type FormulaPayload struct {
	Config         cfg.Config
	MacOSDownloads []github.Download
	LinuxDownloads []github.Download
	Tag            string
	CacheComment   string
}

// ReadmePayload represents the data structure passed to README templates.
type ReadmePayload struct {
	Configs []cfg.Config
}

// init compiles all templates at package initialization.
func init() {
	compiled = template.Must(template.New("formula").Funcs(funcmap).ParseFS(files, "*.gotmpl"))
}

// deduplicateDownloadsByArchitecture removes duplicate downloads for the same architecture,
// preferring LIBC over MUSL when both are available for the same platform and architecture.
// This function preserves the original order of downloads.
func deduplicateDownloadsByArchitecture(downloads []github.Download) []github.Download {
	// Create a map to track the best download for each architecture
	architectureMap := make(map[string]github.Download)
	// Keep track of order using a slice
	var keyOrder []string

	for _, download := range downloads {
		// Create a unique key for platform + architecture combination
		var key string
		if download.IsIntel() {
			key = "intel"
		} else if download.IsARM64() {
			key = "arm64"
		} else if download.IsARM() {
			key = "arm"
		} else {
			continue // Skip unsupported architectures
		}

		// Check if we already have a download for this architecture
		if existing, exists := architectureMap[key]; exists {
			// If the existing download is MUSL and the new one is LIBC, prefer LIBC
			if strings.Contains(strings.ToLower(existing.Filename), "musl") &&
				!strings.Contains(strings.ToLower(download.Filename), "musl") {
				architectureMap[key] = download
			}
			// Otherwise, keep the existing one (first wins if both are same type)
		} else {
			// First download for this architecture - record the order
			architectureMap[key] = download
			keyOrder = append(keyOrder, key)
		}
	}

	// Convert map back to slice in original order
	result := make([]github.Download, 0, len(architectureMap))
	for _, key := range keyOrder {
		result = append(result, architectureMap[key])
	}

	return result
}

// GenerateFormula generates a Homebrew formula from the given configuration and downloads.
func GenerateFormula(config cfg.Config, tag string, downloads []github.Download, cache *github.FormulaCache) (string, error) {
	payload := FormulaPayload{
		Config: config,
		Tag:    tag,
	}

	// Generate cache comment if cache is provided
	if cache != nil {
		cacheComment, err := github.FormatCacheComment(cache)
		if err != nil {
			return "", err
		}
		payload.CacheComment = cacheComment
	}

	// Separate downloads by platform and deduplicate by architecture
	for _, download := range downloads {
		if download.IsMacOS() {
			payload.MacOSDownloads = append(payload.MacOSDownloads, download)
		} else if download.IsLinux() {
			payload.LinuxDownloads = append(payload.LinuxDownloads, download)
		}
	}

	// Deduplicate downloads by architecture to prevent duplicate conditional blocks
	payload.MacOSDownloads = deduplicateDownloadsByArchitecture(payload.MacOSDownloads)
	payload.LinuxDownloads = deduplicateDownloadsByArchitecture(payload.LinuxDownloads)

	var buf bytes.Buffer
	if err := compiled.ExecuteTemplate(&buf, "formula.rb.gotmpl", payload); err != nil {
		return "", err
	}

	return buf.String(), nil
}

// GenerateReadme generates a README file from the given configurations using the specified template.
// The templatePath parameter is required.
func GenerateReadme(configs []cfg.Config, templatePath string) (string, error) {
	if templatePath == "" {
		return "", fmt.Errorf("template path is required")
	}

	payload := ReadmePayload{
		Configs: configs,
	}

	tmpl, err := createCustomTemplate(templatePath)
	if err != nil {
		return "", fmt.Errorf("failed to create template: %w", err)
	}

	var buf bytes.Buffer
	if err := tmpl.Execute(&buf, payload); err != nil {
		return "", fmt.Errorf("failed to execute template: %w", err)
	}

	return buf.String(), nil
}

// createCustomTemplate creates a template from an external file with the same functions as the embedded templates.
func createCustomTemplate(templatePath string) (*template.Template, error) {
	content, err := os.ReadFile(templatePath)
	if err != nil {
		return nil, fmt.Errorf("failed to read template file %q: %w", templatePath, err)
	}

	tmpl, err := template.New("readme").Funcs(funcmap).Parse(string(content))
	if err != nil {
		return nil, fmt.Errorf("failed to parse template file %q: %w", templatePath, err)
	}

	return tmpl, nil
}

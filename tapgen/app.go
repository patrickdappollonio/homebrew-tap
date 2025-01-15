package tapgen

import (
	"bytes"
	"context"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/github"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/template"
	"github.com/spf13/cobra"
)

func Run() error {
	var configLocation, onlygenerate string

	cmd := &cobra.Command{
		Use:   os.Args[0],
		Short: "Generate Homebrew formulas for GitHub releases based off a config file.",
		RunE: func(cmd *cobra.Command, args []string) error {
			return execute(configLocation, onlygenerate)
		},
	}

	cmd.Flags().StringVarP(&configLocation, "config", "c", "config.yaml", "Location of the configuration file to use")
	cmd.Flags().StringVarP(&onlygenerate, "target", "t", "", "Only generate the formula for the specified package target as specified in the config file's \"name\" field")

	return cmd.Execute()
}

func execute(configLocation, only string) error {
	formulas, err := cfg.ParseConfig(configLocation)
	if err != nil {
		return fmt.Errorf("could not parse config: %w", err)
	}

	if only != "" {
		found := false

		for _, v := range formulas {
			if v.Name == only {
				formulas = []cfg.Config{v}
				found = true
				break
			}
		}

		if !found {
			return fmt.Errorf("could not find package %q in the configuration", only)
		}
	}

	log.Printf("Found %d formulas to generate", len(formulas))

	ctx := context.Background()
	token := envdefault("GITHUB_TOKEN", "")

	for _, v := range formulas {
		log.Printf("Fetching latest download for %q (repo: %q)", v.Name, v.Repository)
		tag, downloads, err := github.GetLatestDownloads(ctx, token, v.Repository)
		if err != nil {
			return fmt.Errorf("could not get latest download for %q: %w", v.Name, err)
		}

		formulaFile := filepath.Join(
			"Formula",
			fmt.Sprintf("%s.rb", strings.ToLower(v.Name)),
		)

		log.Printf("Found %d downloads for %q (version: %s); generating formula file: %s", len(downloads), v.Name, tag, formulaFile)

		f, err := os.OpenFile(formulaFile, os.O_CREATE|os.O_RDWR, 0o644)
		if err != nil {
			return fmt.Errorf("could not open file for writing: %w", err)
		}
		defer f.Close()

		var current bytes.Buffer
		if _, err := current.ReadFrom(f); err != nil {
			return fmt.Errorf("could not read current formula file: %w", err)
		}

		formula, err := template.GenerateFormula(v, tag, downloads)
		if err != nil {
			return fmt.Errorf("could not generate formula: %w", err)
		}

		if current.String() == formula {
			log.Printf("Formula file %q is up to date, skipping...", formulaFile)
			continue
		}

		if err := f.Truncate(0); err != nil {
			return fmt.Errorf("could not truncate formula file: %w", err)
		}

		if _, err = f.Seek(0, 0); err != nil {
			return fmt.Errorf("could not seek to beginning of formula file: %w", err)
		}

		if _, err := f.WriteString(formula); err != nil {
			return fmt.Errorf("could not write formula to file: %w", err)
		}

		log.Printf("Formula file %q generated successfully", formulaFile)
	}

	return nil
}

func envdefault(key, defval string) string {
	if val := strings.TrimSpace(os.Getenv(key)); val != "" {
		return val
	}
	return defval
}

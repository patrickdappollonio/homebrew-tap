// Package cfg provides configuration parsing and validation for tapgen.
package cfg

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/licenses"
	"gopkg.in/yaml.v3"
)

// Config represents a single package configuration for generating Homebrew formulas.
type Config struct {
	Name           string          `yaml:"name"`
	Repository     string          `yaml:"repository"`
	Description    string          `yaml:"description"`
	URL            string          `yaml:"url"`
	TestCommand    string          `yaml:"test_command"`
	InstallAliases []string        `yaml:"install_aliases"`
	RenameBinary   string          `yaml:"rename_binary"`
	ConflictsWith  []ConflictsWith `yaml:"conflicts_with"`
	Caveats        string          `yaml:"caveats"`
	License        string          `yaml:"license"`
}

// ConflictsWith represents a package that conflicts with this one.
type ConflictsWith struct {
	Name   string `yaml:"name"`
	Reason string `yaml:"reason"`
}

// GenerateURL returns the URL for the package, using the repository URL if no explicit URL is provided.
func (c Config) GenerateURL() string {
	if c.URL != "" {
		return c.URL
	}
	return "https://github.com/" + c.Repository
}

// NormalizedName returns the package name in lowercase with only alphanumeric characters.
func (c Config) NormalizedName() string {
	return normalizeString(c.Name)
}

// ValidateLicense checks if the license is valid according to SPDX standards.
func (c Config) ValidateLicense() error {
	if c.License == "" {
		return nil
	}

	if !licenses.Valid(c.License) {
		return fmt.Errorf("license %q is not a valid SPDX license, see list at: https://spdx.org/licenses/", c.License)
	}

	return nil
}

// ParseConfig parses a configuration file and returns the configuration objects.
func ParseConfig(location string) ([]Config, error) {
	configs, err := parseConfigFile(location)
	if err != nil {
		return nil, err
	}

	return validateConfigs(configs)
}

// parseConfigFile reads and parses the YAML configuration file.
func parseConfigFile(location string) ([]Config, error) {
	if location == "" {
		location = "."
	}

	fullpath, err := filepath.Abs(location)
	if err != nil {
		return nil, fmt.Errorf("failed to get absolute path for %q: %w", location, err)
	}

	f, err := os.Open(fullpath)
	if err != nil {
		return nil, fmt.Errorf("failed to open file %q: %w", fullpath, err)
	}
	defer f.Close()

	var configs []Config
	if err := yaml.NewDecoder(f).Decode(&configs); err != nil {
		return nil, fmt.Errorf("failed to decode %q: %w", fullpath, err)
	}

	return configs, nil
}

// validateConfigs validates all configurations in the slice.
func validateConfigs(configs []Config) ([]Config, error) {
	for _, config := range configs {
		if err := config.ValidateLicense(); err != nil {
			return nil, fmt.Errorf("failed to validate license for %q: %w", config.Name, err)
		}
	}
	return configs, nil
}

// normalizeString converts a string to lowercase and removes all non-alphanumeric characters.
func normalizeString(s string) string {
	s = strings.ToLower(s)
	return strings.Map(func(r rune) rune {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') {
			return r
		}
		return -1
	}, s)
}

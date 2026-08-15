// Package cfg provides configuration parsing and validation for tapgen.
package cfg

import (
	"fmt"
	"os"
	"path"
	"path/filepath"
	"strings"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/licenses"
	"gopkg.in/yaml.v3"
)

// Kind values supported in the "kind" configuration field.
const (
	KindFormula = "formula"
	KindCask    = "cask"
)

// Config represents a single package configuration for generating Homebrew formulas.
type Config struct {
	Name           string          `yaml:"name"`
	Kind           string          `yaml:"kind"`
	Repository     string          `yaml:"repository"`
	Description    string          `yaml:"description"`
	URL            string          `yaml:"url"`
	TestCommand    string          `yaml:"test_command"`
	InstallAliases []string        `yaml:"install_aliases"`
	RenameBinary   string          `yaml:"rename_binary"`
	ConflictsWith  []ConflictsWith `yaml:"conflicts_with"`
	Caveats        string          `yaml:"caveats"`
	License        string          `yaml:"license"`
	AssetFilter    []string        `yaml:"asset_filter"`
	AppName        string          `yaml:"app_name"`
	DisplayName    string          `yaml:"display_name"`
	CaskBinary     bool            `yaml:"cask_binary"`
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

// IsCask returns true if the package should be generated as a Homebrew cask.
func (c Config) IsCask() bool {
	return c.Kind == KindCask
}

// CaskDisplayName returns the human-readable name for a cask, using the
// explicit display name when set and otherwise deriving it from the app
// bundle name without its ".app" extension.
func (c Config) CaskDisplayName() string {
	if c.DisplayName != "" {
		return c.DisplayName
	}
	return strings.TrimSuffix(c.AppName, ".app")
}

// ValidateKind checks if the kind is one of the supported values and that
// cask-specific requirements are met.
func (c Config) ValidateKind() error {
	switch c.Kind {
	case "", KindFormula:
		return nil
	case KindCask:
		if c.AppName == "" {
			return fmt.Errorf("kind %q requires an \"app_name\" to be set", c.Kind)
		}
		return nil
	default:
		return fmt.Errorf("kind %q is not valid, must be one of: %q, %q", c.Kind, KindFormula, KindCask)
	}
}

// ValidateAssetFilter checks if all asset filter globs are valid patterns.
func (c Config) ValidateAssetFilter() error {
	for _, pattern := range c.AssetFilter {
		if _, err := path.Match(pattern, ""); err != nil {
			return fmt.Errorf("asset filter %q is not a valid glob pattern: %w", pattern, err)
		}
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
		if err := config.ValidateKind(); err != nil {
			return nil, fmt.Errorf("failed to validate kind for %q: %w", config.Name, err)
		}
		if err := config.ValidateAssetFilter(); err != nil {
			return nil, fmt.Errorf("failed to validate asset filter for %q: %w", config.Name, err)
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

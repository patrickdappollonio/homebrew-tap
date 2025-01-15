package cfg

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"gopkg.in/yaml.v3"
)

type Config struct {
	Name           string          `yaml:"name"`
	Repository     string          `yaml:"repository"`
	Description    string          `yaml:"description"`
	URL            string          `yaml:"url"`
	TestCommand    string          `yaml:"test_command"`
	InstallAliases []string        `yaml:"install_aliases"`
	RenameBinary   string          `yaml:"rename_binary"`
	ConflictsWith  []ConflictsWith `yaml:"conflicts_with"`
}

type ConflictsWith struct {
	Name   string `yaml:"name"`
	Reason string `yaml:"reason"`
}

func (c Config) GenerateURL() string {
	if c.URL != "" {
		return c.URL
	}

	return "https://github.com/" + c.Repository
}

func (c Config) GenerateLowercaseNameNoDashes() string {
	name := strings.ToLower(c.Name)
	return strings.Map(func(r rune) rune {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') {
			return r
		}
		return -1
	}, name)
}

func ParseConfig(location string) ([]Config, error) {
	if location == "" {
		location = "."
	}

	fullpath, err := filepath.Abs(location)
	if err != nil {
		return nil, fmt.Errorf("could not get absolute path for %s: %w", location, err)
	}

	f, err := os.Open(fullpath)
	if err != nil {
		return nil, fmt.Errorf("could not open file %s: %w", fullpath, err)
	}
	defer f.Close()

	var cfg []Config
	if err := yaml.NewDecoder(f).Decode(&cfg); err != nil {
		return nil, fmt.Errorf("could not decode %s: %w", fullpath, err)
	}

	return cfg, nil
}

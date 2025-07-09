package cfg

import (
	"os"
	"path/filepath"
	"testing"
)

func TestConfig_GenerateURL(t *testing.T) {
	tests := []struct {
		name     string
		config   Config
		expected string
	}{
		{
			name: "explicit URL provided",
			config: Config{
				URL:        "https://example.com/project",
				Repository: "user/repo",
			},
			expected: "https://example.com/project",
		},
		{
			name: "no URL provided, use repository",
			config: Config{
				Repository: "user/repo",
			},
			expected: "https://github.com/user/repo",
		},
		{
			name: "empty repository",
			config: Config{
				Repository: "",
			},
			expected: "https://github.com/",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := tt.config.GenerateURL()
			if result != tt.expected {
				t.Errorf("GenerateURL() = %q; expected %q", result, tt.expected)
			}
		})
	}
}

func TestConfig_NormalizedName(t *testing.T) {
	tests := []struct {
		name     string
		config   Config
		expected string
	}{
		{
			name: "simple name",
			config: Config{
				Name: "test",
			},
			expected: "test",
		},
		{
			name: "name with dashes",
			config: Config{
				Name: "my-app",
			},
			expected: "myapp",
		},
		{
			name: "name with underscores",
			config: Config{
				Name: "my_app",
			},
			expected: "myapp",
		},
		{
			name: "name with numbers",
			config: Config{
				Name: "app-v2",
			},
			expected: "appv2",
		},
		{
			name: "name with special characters",
			config: Config{
				Name: "my@app!",
			},
			expected: "myapp",
		},
		{
			name: "mixed case",
			config: Config{
				Name: "MyApp",
			},
			expected: "myapp",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := tt.config.NormalizedName()
			if result != tt.expected {
				t.Errorf("NormalizedName() = %q; expected %q", result, tt.expected)
			}
		})
	}
}

func TestConfig_ValidateLicense(t *testing.T) {
	tests := []struct {
		name        string
		config      Config
		expectError bool
	}{
		{
			name: "valid license MIT",
			config: Config{
				License: "MIT",
			},
			expectError: false,
		},
		{
			name: "valid license Apache-2.0",
			config: Config{
				License: "Apache-2.0",
			},
			expectError: false,
		},
		{
			name: "empty license",
			config: Config{
				License: "",
			},
			expectError: false,
		},
		{
			name: "invalid license",
			config: Config{
				License: "NOT-A-REAL-LICENSE",
			},
			expectError: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := tt.config.ValidateLicense()
			if tt.expectError && err == nil {
				t.Error("expected error but got none")
			}
			if !tt.expectError && err != nil {
				t.Errorf("unexpected error: %v", err)
			}
		})
	}
}

func TestParseConfig(t *testing.T) {
	// Create a temporary config file
	tempDir := t.TempDir()
	configFile := filepath.Join(tempDir, "config.yaml")

	validConfig := `
- name: test-app
  repository: user/test-app
  description: A test application
  license: MIT
  test_command: test-app --version
  install_aliases:
    - ta
    - testapp
  conflicts_with:
    - name: other-app
      reason: conflicts with functionality
  caveats: This is a test application

- name: another-app
  repository: user/another-app
  description: Another test application
  license: Apache-2.0
`

	err := os.WriteFile(configFile, []byte(validConfig), 0o644)
	if err != nil {
		t.Fatalf("failed to write test config file: %v", err)
	}

	t.Run("valid config file", func(t *testing.T) {
		configs, err := ParseConfig(configFile)
		if err != nil {
			t.Fatalf("unexpected error: %v", err)
		}

		if len(configs) != 2 {
			t.Errorf("expected 2 configs; got %d", len(configs))
		}

		// Check first config
		if configs[0].Name != "test-app" {
			t.Errorf("expected first config name to be 'test-app'; got %q", configs[0].Name)
		}

		if configs[0].Repository != "user/test-app" {
			t.Errorf("expected first config repository to be 'user/test-app'; got %q", configs[0].Repository)
		}

		if len(configs[0].InstallAliases) != 2 {
			t.Errorf("expected 2 install aliases; got %d", len(configs[0].InstallAliases))
		}

		if len(configs[0].ConflictsWith) != 1 {
			t.Errorf("expected 1 conflict; got %d", len(configs[0].ConflictsWith))
		}

		// Check second config
		if configs[1].Name != "another-app" {
			t.Errorf("expected second config name to be 'another-app'; got %q", configs[1].Name)
		}

		if configs[1].License != "Apache-2.0" {
			t.Errorf("expected second config license to be 'Apache-2.0'; got %q", configs[1].License)
		}
	})

	t.Run("non-existent config file", func(t *testing.T) {
		_, err := ParseConfig("/non/existent/file.yaml")
		if err == nil {
			t.Error("expected error for non-existent file")
		}
	})

	t.Run("invalid YAML", func(t *testing.T) {
		invalidConfigFile := filepath.Join(tempDir, "invalid.yaml")
		err := os.WriteFile(invalidConfigFile, []byte("invalid: yaml: content:"), 0o644)
		if err != nil {
			t.Fatalf("failed to write invalid config file: %v", err)
		}

		_, err = ParseConfig(invalidConfigFile)
		if err == nil {
			t.Error("expected error for invalid YAML")
		}
	})

	t.Run("invalid license in config", func(t *testing.T) {
		invalidLicenseConfig := `
- name: test-app
  repository: user/test-app
  description: A test application
  license: INVALID-LICENSE
`
		invalidLicenseConfigFile := filepath.Join(tempDir, "invalid-license.yaml")
		err := os.WriteFile(invalidLicenseConfigFile, []byte(invalidLicenseConfig), 0o644)
		if err != nil {
			t.Fatalf("failed to write invalid license config file: %v", err)
		}

		_, err = ParseConfig(invalidLicenseConfigFile)
		if err == nil {
			t.Error("expected error for invalid license")
		}
	})

	t.Run("empty location defaults to current directory", func(t *testing.T) {
		// This test is harder to implement without changing the current directory
		// For now, just ensure it doesn't panic
		_, err := ParseConfig("")
		// We expect an error because there's no config.yaml in the current directory
		if err == nil {
			t.Log("ParseConfig with empty location returned no error (config.yaml exists in current directory)")
		}
	})
}

func TestNormalizeString(t *testing.T) {
	tests := []struct {
		name     string
		input    string
		expected string
	}{
		{
			name:     "simple string",
			input:    "test",
			expected: "test",
		},
		{
			name:     "string with dashes",
			input:    "my-app",
			expected: "myapp",
		},
		{
			name:     "string with underscores",
			input:    "my_app",
			expected: "myapp",
		},
		{
			name:     "string with numbers",
			input:    "app123",
			expected: "app123",
		},
		{
			name:     "string with special characters",
			input:    "my@app!",
			expected: "myapp",
		},
		{
			name:     "mixed case",
			input:    "MyApp",
			expected: "myapp",
		},
		{
			name:     "empty string",
			input:    "",
			expected: "",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := normalizeString(tt.input)
			if result != tt.expected {
				t.Errorf("normalizeString(%q) = %q; expected %q", tt.input, result, tt.expected)
			}
		})
	}
}

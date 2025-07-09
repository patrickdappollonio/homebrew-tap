package tapgen

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
)

func TestFilterConfigs(t *testing.T) {
	configs := []cfg.Config{
		{Name: "app1", Repository: "user/app1"},
		{Name: "app2", Repository: "user/app2"},
		{Name: "app3", Repository: "user/app3"},
	}

	t.Run("no target package returns all configs", func(t *testing.T) {
		result, err := filterConfigs(configs, "")
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		if len(result) != 3 {
			t.Errorf("expected 3 configs; got %d", len(result))
		}
	})

	t.Run("target package found", func(t *testing.T) {
		result, err := filterConfigs(configs, "app2")
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		if len(result) != 1 {
			t.Errorf("expected 1 config; got %d", len(result))
		}

		if result[0].Name != "app2" {
			t.Errorf("expected config name 'app2'; got %q", result[0].Name)
		}
	})

	t.Run("target package not found", func(t *testing.T) {
		_, err := filterConfigs(configs, "nonexistent")
		if err == nil {
			t.Error("expected error for non-existent package")
		}

		expectedMsg := "package \"nonexistent\" not found in configuration"
		if err.Error() != expectedMsg {
			t.Errorf("expected error message %q; got %q", expectedMsg, err.Error())
		}
	})

	t.Run("empty configs slice", func(t *testing.T) {
		emptyConfigs := []cfg.Config{}
		_, err := filterConfigs(emptyConfigs, "app1")
		if err == nil {
			t.Error("expected error for empty configs")
		}
	})
}

func TestReadFileIfExists(t *testing.T) {
	tempDir := t.TempDir()

	t.Run("file exists", func(t *testing.T) {
		testFile := filepath.Join(tempDir, "test.txt")
		testContent := "test content"

		err := os.WriteFile(testFile, []byte(testContent), 0o644)
		if err != nil {
			t.Fatalf("failed to write test file: %v", err)
		}

		result, err := readFileIfExists(testFile)
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		if result != testContent {
			t.Errorf("expected content %q; got %q", testContent, result)
		}
	})

	t.Run("file does not exist", func(t *testing.T) {
		nonExistentFile := filepath.Join(tempDir, "nonexistent.txt")

		result, err := readFileIfExists(nonExistentFile)
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		if result != "" {
			t.Errorf("expected empty string; got %q", result)
		}
	})

	t.Run("file exists but is empty", func(t *testing.T) {
		emptyFile := filepath.Join(tempDir, "empty.txt")

		err := os.WriteFile(emptyFile, []byte(""), 0o644)
		if err != nil {
			t.Fatalf("failed to write empty file: %v", err)
		}

		result, err := readFileIfExists(emptyFile)
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		if result != "" {
			t.Errorf("expected empty string; got %q", result)
		}
	})
}

func TestWriteFormulaFile(t *testing.T) {
	tempDir := t.TempDir()

	t.Run("write new file", func(t *testing.T) {
		testFile := filepath.Join(tempDir, "new.rb")
		testContent := "# Formula content"

		err := writeFormulaFile(testFile, testContent)
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		// Verify file was created with correct content
		content, err := os.ReadFile(testFile)
		if err != nil {
			t.Fatalf("failed to read file: %v", err)
		}

		if string(content) != testContent {
			t.Errorf("expected content %q; got %q", testContent, string(content))
		}
	})

	t.Run("update existing file with different content", func(t *testing.T) {
		testFile := filepath.Join(tempDir, "existing.rb")
		oldContent := "# Old content"
		newContent := "# New content"

		// Create file with old content
		err := os.WriteFile(testFile, []byte(oldContent), 0o644)
		if err != nil {
			t.Fatalf("failed to write initial file: %v", err)
		}

		err = writeFormulaFile(testFile, newContent)
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		// Verify file was updated with new content
		content, err := os.ReadFile(testFile)
		if err != nil {
			t.Fatalf("failed to read file: %v", err)
		}

		if string(content) != newContent {
			t.Errorf("expected content %q; got %q", newContent, string(content))
		}
	})

	t.Run("skip write when content is same", func(t *testing.T) {
		testFile := filepath.Join(tempDir, "same.rb")
		testContent := "# Same content"

		// Create file with test content
		err := os.WriteFile(testFile, []byte(testContent), 0o644)
		if err != nil {
			t.Fatalf("failed to write initial file: %v", err)
		}

		// Get initial modification time
		info1, err := os.Stat(testFile)
		if err != nil {
			t.Fatalf("failed to stat file: %v", err)
		}

		// Call writeFormulaFile with same content
		err = writeFormulaFile(testFile, testContent)
		if err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		// Verify file was not modified
		info2, err := os.Stat(testFile)
		if err != nil {
			t.Fatalf("failed to stat file: %v", err)
		}

		if info1.ModTime() != info2.ModTime() {
			t.Error("file was modified when it should have been skipped")
		}
	})
}

func TestGetGitHubToken(t *testing.T) {
	// Save original environment
	originalToken := os.Getenv("GITHUB_TOKEN")
	defer func() {
		if originalToken != "" {
			os.Setenv("GITHUB_TOKEN", originalToken)
		} else {
			os.Unsetenv("GITHUB_TOKEN")
		}
	}()

	t.Run("token exists", func(t *testing.T) {
		testToken := "test-token"
		os.Setenv("GITHUB_TOKEN", testToken)

		result := getGitHubToken()
		if result != testToken {
			t.Errorf("expected token %q; got %q", testToken, result)
		}
	})

	t.Run("token with spaces", func(t *testing.T) {
		testToken := "  test-token  "
		expectedToken := "test-token"
		os.Setenv("GITHUB_TOKEN", testToken)

		result := getGitHubToken()
		if result != expectedToken {
			t.Errorf("expected token %q; got %q", expectedToken, result)
		}
	})

	t.Run("empty token", func(t *testing.T) {
		os.Unsetenv("GITHUB_TOKEN")

		result := getGitHubToken()
		if result != "" {
			t.Errorf("expected empty string; got %q", result)
		}
	})

	t.Run("token with only spaces", func(t *testing.T) {
		os.Setenv("GITHUB_TOKEN", "   ")

		result := getGitHubToken()
		if result != "" {
			t.Errorf("expected empty string; got %q", result)
		}
	})
}

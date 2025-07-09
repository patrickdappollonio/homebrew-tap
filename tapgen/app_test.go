package tapgen

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/github"
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

func TestSortDownloads(t *testing.T) {
	// Create test downloads with different platforms and architectures
	downloads := []github.Download{
		{Filename: "app-linux-arm.tar.gz", URL: "https://example.com/app-linux-arm.tar.gz", SHA256: "hash1"},
		{Filename: "app-darwin-arm64.tar.gz", URL: "https://example.com/app-darwin-arm64.tar.gz", SHA256: "hash2"},
		{Filename: "app-linux-amd64.tar.gz", URL: "https://example.com/app-linux-amd64.tar.gz", SHA256: "hash3"},
		{Filename: "app-darwin-amd64.tar.gz", URL: "https://example.com/app-darwin-amd64.tar.gz", SHA256: "hash4"},
		{Filename: "app-linux-arm64.tar.gz", URL: "https://example.com/app-linux-arm64.tar.gz", SHA256: "hash5"},
		{Filename: "app-darwin-x86_64.tar.gz", URL: "https://example.com/app-darwin-x86_64.tar.gz", SHA256: "hash6"},
	}

	// Sort the downloads
	sortDownloads(downloads)

	// Expected order:
	// 1. MacOS ARM64 (darwin-arm64)
	// 2. MacOS Intel (darwin-amd64, darwin-x86_64) - sorted by filename
	// 3. Linux Intel (linux-amd64)
	// 4. Linux ARM64 (linux-arm64)
	// 5. Linux ARM (linux-arm)
	expectedOrder := []string{
		"app-darwin-arm64.tar.gz",  // MacOS ARM64
		"app-darwin-amd64.tar.gz",  // MacOS Intel
		"app-darwin-x86_64.tar.gz", // MacOS Intel (sorted by filename)
		"app-linux-amd64.tar.gz",   // Linux Intel
		"app-linux-arm64.tar.gz",   // Linux ARM64
		"app-linux-arm.tar.gz",     // Linux ARM
	}

	if len(downloads) != len(expectedOrder) {
		t.Fatalf("Expected %d downloads, got %d", len(expectedOrder), len(downloads))
	}

	for i, expected := range expectedOrder {
		if downloads[i].Filename != expected {
			t.Errorf("Expected download %d to be %s, got %s", i, expected, downloads[i].Filename)
		}
	}
}

func TestGetArchitecturePriority(t *testing.T) {
	testCases := []struct {
		filename string
		expected int
	}{
		// Linux priorities: Intel first, then ARM64, then ARM
		{"app-linux-amd64.tar.gz", 1}, // Linux Intel
		{"app-linux-arm64.tar.gz", 2}, // Linux ARM64
		{"app-linux-arm.tar.gz", 3},   // Linux ARM

		// MacOS priorities: ARM64 first, then Intel, then ARM
		{"app-darwin-arm64.tar.gz", 1},  // MacOS ARM64
		{"app-darwin-x86_64.tar.gz", 2}, // MacOS Intel
		{"app-darwin-arm.tar.gz", 3},    // MacOS ARM

		// Unknown architecture
		{"app-unknown.tar.gz", 4}, // Unknown
	}

	for _, tc := range testCases {
		t.Run(tc.filename, func(t *testing.T) {
			download := github.Download{Filename: tc.filename}
			priority := getArchitecturePriority(download)
			if priority != tc.expected {
				t.Errorf("Expected priority %d for %s, got %d", tc.expected, tc.filename, priority)
			}
		})
	}
}

func TestSortDownloadsDeterministic(t *testing.T) {
	// Create identical downloads in different orders
	downloads1 := []github.Download{
		{Filename: "z-linux-amd64.tar.gz", URL: "https://example.com/z", SHA256: "hash1"},
		{Filename: "a-linux-amd64.tar.gz", URL: "https://example.com/a", SHA256: "hash2"},
		{Filename: "m-linux-amd64.tar.gz", URL: "https://example.com/m", SHA256: "hash3"},
	}

	downloads2 := []github.Download{
		{Filename: "m-linux-amd64.tar.gz", URL: "https://example.com/m", SHA256: "hash3"},
		{Filename: "a-linux-amd64.tar.gz", URL: "https://example.com/a", SHA256: "hash2"},
		{Filename: "z-linux-amd64.tar.gz", URL: "https://example.com/z", SHA256: "hash1"},
	}

	// Sort both slices
	sortDownloads(downloads1)
	sortDownloads(downloads2)

	// They should be identical after sorting
	if len(downloads1) != len(downloads2) {
		t.Fatalf("Downloads have different lengths: %d vs %d", len(downloads1), len(downloads2))
	}

	for i := range downloads1 {
		if downloads1[i].Filename != downloads2[i].Filename {
			t.Errorf("Downloads differ at position %d: %s vs %s", i, downloads1[i].Filename, downloads2[i].Filename)
		}
	}

	// Expected alphabetical order
	expected := []string{
		"a-linux-amd64.tar.gz",
		"m-linux-amd64.tar.gz",
		"z-linux-amd64.tar.gz",
	}

	for i, expectedFilename := range expected {
		if downloads1[i].Filename != expectedFilename {
			t.Errorf("Expected %s at position %d, got %s", expectedFilename, i, downloads1[i].Filename)
		}
	}
}

func TestSortDownloadsSpecificOrder(t *testing.T) {
	// Create test downloads with mixed platforms and architectures
	downloads := []github.Download{
		{Filename: "app-linux-arm64.tar.gz", URL: "https://example.com/app-linux-arm64.tar.gz", SHA256: "hash1"},
		{Filename: "app-darwin-amd64.tar.gz", URL: "https://example.com/app-darwin-amd64.tar.gz", SHA256: "hash2"},
		{Filename: "app-linux-amd64.tar.gz", URL: "https://example.com/app-linux-amd64.tar.gz", SHA256: "hash3"},
		{Filename: "app-darwin-arm64.tar.gz", URL: "https://example.com/app-darwin-arm64.tar.gz", SHA256: "hash4"},
		{Filename: "app-linux-arm.tar.gz", URL: "https://example.com/app-linux-arm.tar.gz", SHA256: "hash5"},
		{Filename: "app-darwin-arm.tar.gz", URL: "https://example.com/app-darwin-arm.tar.gz", SHA256: "hash6"},
	}

	// Sort the downloads
	sortDownloads(downloads)

	// Expected order based on requirements:
	// 1. Mac apps first
	// 2. ARM64 mac app first (within Mac apps)
	// 3. Then Linux apps after all Mac apps
	// 4. Linux AMD64 first (within Linux apps)
	// 5. Then the remaining linux apps
	expectedOrder := []string{
		"app-darwin-arm64.tar.gz", // Mac ARM64 first
		"app-darwin-amd64.tar.gz", // Mac AMD64 second
		"app-darwin-arm.tar.gz",   // Mac ARM third
		"app-linux-amd64.tar.gz",  // Linux AMD64 first
		"app-linux-arm64.tar.gz",  // Linux ARM64 second
		"app-linux-arm.tar.gz",    // Linux ARM third
	}

	if len(downloads) != len(expectedOrder) {
		t.Fatalf("Expected %d downloads, got %d", len(expectedOrder), len(downloads))
	}

	for i, expected := range expectedOrder {
		if downloads[i].Filename != expected {
			t.Errorf("Expected download %d to be %s, got %s", i, expected, downloads[i].Filename)
		}
	}
}

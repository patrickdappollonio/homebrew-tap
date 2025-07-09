package github

import (
	"os"
	"strings"
	"testing"
	"time"
)

func TestParseCacheFromFormula(t *testing.T) {
	tests := []struct {
		name        string
		content     string
		expectCache bool
		expectError bool
	}{
		{
			name: "valid cache",
			content: `class Test < Formula
  desc "test"
end

# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"test/repo","cached_at":"2024-01-01T00:00:00Z","assets":[{"id":123,"filename":"test.tar.gz","url":"https://example.com","sha256":"abc123"}]}`,
			expectCache: true,
			expectError: false,
		},
		{
			name: "invalid JSON",
			content: `class Test < Formula
  desc "test"
end

# TAPGEN_CACHE: {invalid json`,
			expectCache: false,
			expectError: true,
		},
		{
			name: "no cache",
			content: `class Test < Formula
  desc "test"
end`,
			expectCache: false,
			expectError: false,
		},
		{
			name:        "empty file",
			content:     "",
			expectCache: false,
			expectError: false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create temporary file
			tmpFile, err := os.CreateTemp("", "test_*.rb")
			if err != nil {
				t.Fatal(err)
			}
			defer os.Remove(tmpFile.Name())

			// Write test content
			if _, err := tmpFile.WriteString(tt.content); err != nil {
				t.Fatal(err)
			}
			tmpFile.Close()

			// Test parsing
			cache, err := ParseCacheFromFormula(tmpFile.Name())

			if tt.expectError && err == nil {
				t.Error("expected error but got none")
			}
			if !tt.expectError && err != nil {
				t.Errorf("unexpected error: %v", err)
			}
			if tt.expectCache && cache == nil {
				t.Error("expected cache but got nil")
			}
			if !tt.expectCache && cache != nil {
				t.Error("expected no cache but got one")
			}

			// Validate cache content if expected
			if tt.expectCache && cache != nil {
				if cache.Tag != "v1.0.0" {
					t.Errorf("expected tag v1.0.0, got %s", cache.Tag)
				}
				if cache.Repository != "test/repo" {
					t.Errorf("expected repository test/repo, got %s", cache.Repository)
				}
				if len(cache.Assets) != 1 {
					t.Errorf("expected 1 asset, got %d", len(cache.Assets))
				}
			}
		})
	}
}

func TestFormatCacheComment(t *testing.T) {
	tests := []struct {
		name        string
		cache       *FormulaCache
		expectEmpty bool
		expectError bool
	}{
		{
			name:        "nil cache",
			cache:       nil,
			expectEmpty: true,
			expectError: false,
		},
		{
			name: "valid cache",
			cache: &FormulaCache{
				Tag:        "v1.0.0",
				Repository: "test/repo",
				CachedAt:   time.Date(2024, 1, 1, 0, 0, 0, 0, time.UTC),
				Assets: []CachedAsset{
					{ID: 123, Filename: "test.tar.gz", URL: "https://example.com", SHA256: "abc123"},
				},
			},
			expectEmpty: false,
			expectError: false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			comment, err := FormatCacheComment(tt.cache)

			if tt.expectError && err == nil {
				t.Error("expected error but got none")
			}
			if !tt.expectError && err != nil {
				t.Errorf("unexpected error: %v", err)
			}
			if tt.expectEmpty && comment != "" {
				t.Errorf("expected empty comment but got: %s", comment)
			}
			if !tt.expectEmpty && comment == "" {
				t.Error("expected non-empty comment but got empty")
			}

			// Validate format if not empty
			if !tt.expectEmpty && comment != "" {
				if !strings.HasPrefix(comment, "# TAPGEN_CACHE: ") {
					t.Errorf("comment should start with '# TAPGEN_CACHE: ', got: %s", comment)
				}
			}
		})
	}
}

func TestTryUseCache(t *testing.T) {
	// Test cache hit - using valid platform/arch patterns
	assets := []releaseAsset{
		{ID: 123, Name: "test1-linux-amd64.tar.gz", BrowserDownloadURL: "https://example.com/test1-linux-amd64.tar.gz"},
		{ID: 456, Name: "test2-darwin-arm64.tar.gz", BrowserDownloadURL: "https://example.com/test2-darwin-arm64.tar.gz"},
	}

	cache := &FormulaCache{
		Assets: []CachedAsset{
			{ID: 123, Filename: "test1-linux-amd64.tar.gz", SHA256: "hash1"},
			{ID: 456, Filename: "test2-darwin-arm64.tar.gz", SHA256: "hash2"},
		},
	}

	downloads := tryUseCache(assets, cache)
	if downloads == nil {
		t.Error("expected cache hit but got cache miss")
	}
	if len(downloads) != 2 {
		t.Errorf("expected 2 downloads, got %d", len(downloads))
	}

	// Test cache miss (asset ID changed)
	assetsChanged := []releaseAsset{
		{ID: 999, Name: "test1-linux-amd64.tar.gz", BrowserDownloadURL: "https://example.com/test1-linux-amd64.tar.gz"},
	}

	downloads2 := tryUseCache(assetsChanged, cache)
	if downloads2 != nil {
		t.Error("expected cache miss but got cache hit")
	}
}

func TestParseNonExistentFile(t *testing.T) {
	cache, err := ParseCacheFromFormula("/non/existent/file.rb")
	if err != nil {
		t.Errorf("expected no error for non-existent file, got: %v", err)
	}
	if cache != nil {
		t.Error("expected nil cache for non-existent file")
	}
}

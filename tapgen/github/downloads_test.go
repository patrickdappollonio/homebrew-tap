package github

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestChecks(t *testing.T) {
	cases := []struct {
		URL       string
		WantMacOS bool
		WantLinux bool
		WantIntel bool
		WantARM   bool
		WantARM64 bool
	}{
		{
			URL:       "foo-darwin-amd64.tar.gz",
			WantMacOS: true,
			WantIntel: true,
		},
		{
			URL:       "duality_linux_arm64.tar.gz",
			WantLinux: true,
			WantARM64: true,
		},
		{
			URL:       "armageddon_linux_amd64.tar.gz",
			WantLinux: true,
			WantIntel: true,
		},
		{
			URL:       "armageddon_linux_arm.tar.gz",
			WantLinux: true,
			WantARM:   true,
			WantARM64: false,
		},
		{
			URL:       "tool_linux_aarch64.tar.gz",
			WantLinux: true,
			WantARM64: true,
		},
		{
			URL:       "tool-darwin-aarch64.tar.gz",
			WantMacOS: true,
			WantARM64: true,
		},
	}

	for _, c := range cases {
		t.Run(c.URL, func(tt *testing.T) {
			d := Download{Filename: c.URL}

			if got := d.IsMacOS(); got != c.WantMacOS {
				tt.Errorf("IsMacOS() = %v; want %v", got, c.WantMacOS)
			}
			if got := d.IsLinux(); got != c.WantLinux {
				tt.Errorf("IsLinux() = %v; want %v", got, c.WantLinux)
			}
			if got := d.IsIntel(); got != c.WantIntel {
				tt.Errorf("IsIntel() = %v; want %v", got, c.WantIntel)
			}
			if got := d.IsARM64(); got != c.WantARM64 {
				tt.Errorf("IsARM() = %v; want %v", got, c.WantARM64)
			}
			if got := d.IsARM(); got != c.WantARM {
				tt.Errorf("IsARM() = %v; want %v", got, c.WantARM)
			}
		})
	}
}

func TestMatchesAssetFilters(t *testing.T) {
	cases := []struct {
		name     string
		filters  []string
		filename string
		want     bool
	}{
		{
			name:     "no filters matches everything",
			filters:  nil,
			filename: "app_1.0.0_linux_amd64.deb",
			want:     true,
		},
		{
			name:     "empty filters matches everything",
			filters:  []string{},
			filename: "app_1.0.0_linux_amd64.deb",
			want:     true,
		},
		{
			name:     "single filter match",
			filters:  []string{"*.tar.gz"},
			filename: "app_1.0.0_linux_amd64.tar.gz",
			want:     true,
		},
		{
			name:     "single filter no match",
			filters:  []string{"*.tar.gz"},
			filename: "app_1.0.0_linux_amd64.deb",
			want:     false,
		},
		{
			name:     "multiple filters second matches",
			filters:  []string{"*.zip", "*.tar.gz"},
			filename: "app_1.0.0_linux_amd64.tar.gz",
			want:     true,
		},
		{
			name:     "infix glob match",
			filters:  []string{"*_darwin_*_app.zip"},
			filename: "claude-usage-tray_1.0.0_darwin_arm64_app.zip",
			want:     true,
		},
		{
			name:     "invalid pattern does not match",
			filters:  []string{"[invalid"},
			filename: "app_1.0.0_linux_amd64.tar.gz",
			want:     false,
		},
	}

	for _, c := range cases {
		t.Run(c.name, func(tt *testing.T) {
			if got := matchesAssetFilters(c.filters, c.filename); got != c.want {
				tt.Errorf("matchesAssetFilters(%v, %q) = %v; want %v", c.filters, c.filename, got, c.want)
			}
		})
	}
}

// newAssetServer returns a test HTTP server that serves a fixed body for any
// asset download, plus a helper to build release assets pointing at it.
func newAssetServer(t *testing.T) (*httptest.Server, func(filenames ...string) []releaseAsset) {
	t.Helper()

	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("fake asset contents"))
	}))
	t.Cleanup(server.Close)

	makeAssets := func(filenames ...string) []releaseAsset {
		assets := make([]releaseAsset, 0, len(filenames))
		for i, filename := range filenames {
			assets = append(assets, releaseAsset{
				ID:                 int64(i + 1),
				Name:               filename,
				State:              "uploaded",
				BrowserDownloadURL: server.URL + "/" + filename,
			})
		}
		return assets
	}

	return server, makeAssets
}

func TestFilterAndProcessAssets_AssetFilters(t *testing.T) {
	_, makeAssets := newAssetServer(t)

	releaseFiles := []string{
		"claude-usage-tray_1.0.0_linux_amd64.tar.gz",
		"claude-usage-tray_1.0.0_linux_arm64.tar.gz",
		"claude-usage-tray_1.0.0_linux_amd64.deb",
		"claude-usage-tray_1.0.0_linux_amd64.rpm",
		"claude-usage-tray_1.0.0_darwin_amd64_app.zip",
		"claude-usage-tray_1.0.0_darwin_arm64_app.zip",
		"claude-usage-tray_1.0.0_windows_amd64.zip",
	}

	cases := []struct {
		name    string
		filters []string
		want    []string
	}{
		{
			name:    "no filter keeps all platform matching assets",
			filters: nil,
			want: []string{
				"claude-usage-tray_1.0.0_linux_amd64.tar.gz",
				"claude-usage-tray_1.0.0_linux_arm64.tar.gz",
				"claude-usage-tray_1.0.0_linux_amd64.deb",
				"claude-usage-tray_1.0.0_linux_amd64.rpm",
				"claude-usage-tray_1.0.0_darwin_amd64_app.zip",
				"claude-usage-tray_1.0.0_darwin_arm64_app.zip",
			},
		},
		{
			name:    "tarball filter excludes deb rpm and zip",
			filters: []string{"*.tar.gz"},
			want: []string{
				"claude-usage-tray_1.0.0_linux_amd64.tar.gz",
				"claude-usage-tray_1.0.0_linux_arm64.tar.gz",
			},
		},
		{
			name:    "darwin app filter keeps only app bundles",
			filters: []string{"*_darwin_*_app.zip"},
			want: []string{
				"claude-usage-tray_1.0.0_darwin_amd64_app.zip",
				"claude-usage-tray_1.0.0_darwin_arm64_app.zip",
			},
		},
		{
			name:    "filter matching nothing returns no assets",
			filters: []string{"*.pkg"},
			want:    []string{},
		},
	}

	for _, c := range cases {
		t.Run(c.name, func(tt *testing.T) {
			downloads, err := filterAndProcessAssets(context.Background(), "", makeAssets(releaseFiles...), false, false, c.filters)
			if err != nil {
				tt.Fatalf("unexpected error: %v", err)
			}

			if len(downloads) != len(c.want) {
				tt.Fatalf("expected %d downloads; got %d (%+v)", len(c.want), len(downloads), downloads)
			}

			for i, want := range c.want {
				if downloads[i].Filename != want {
					tt.Errorf("expected download %d to be %q; got %q", i, want, downloads[i].Filename)
				}
				if downloads[i].SHA256 == "" {
					tt.Errorf("expected download %q to have a SHA256", want)
				}
			}
		})
	}
}

func TestTryUseCache_AssetFilters(t *testing.T) {
	currentAssets := []releaseAsset{
		{ID: 1, Name: "app_1.0.0_linux_amd64.tar.gz", State: "uploaded", BrowserDownloadURL: "https://example.com/app_1.0.0_linux_amd64.tar.gz"},
		{ID: 2, Name: "app_1.0.0_linux_amd64.deb", State: "uploaded", BrowserDownloadURL: "https://example.com/app_1.0.0_linux_amd64.deb"},
	}

	cache := &FormulaCache{
		Tag:        "v1.0.0",
		Repository: "user/app",
		Assets: []CachedAsset{
			{ID: 1, Filename: "app_1.0.0_linux_amd64.tar.gz", URL: "https://example.com/app_1.0.0_linux_amd64.tar.gz", SHA256: "hash1"},
			{ID: 2, Filename: "app_1.0.0_linux_amd64.deb", URL: "https://example.com/app_1.0.0_linux_amd64.deb", SHA256: "hash2"},
		},
	}

	t.Run("no filter keeps all cached assets", func(t *testing.T) {
		downloads := tryUseCache(currentAssets, cache, nil)
		if len(downloads) != 2 {
			t.Fatalf("expected 2 downloads; got %d", len(downloads))
		}
	})

	t.Run("filter excludes cached assets that no longer qualify", func(t *testing.T) {
		downloads := tryUseCache(currentAssets, cache, []string{"*.tar.gz"})
		if len(downloads) != 1 {
			t.Fatalf("expected 1 download; got %d", len(downloads))
		}
		if downloads[0].Filename != "app_1.0.0_linux_amd64.tar.gz" {
			t.Errorf("expected tarball download; got %q", downloads[0].Filename)
		}
	})
}

package template

import (
	_ "embed"
	"strings"
	"testing"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/github"
)

func Test_classify(t *testing.T) {
	tests := []struct {
		str  string
		want string
	}{
		{
			str:  "http-server",
			want: "HttpServer",
		},
		{
			str:  "a",
			want: "A",
		},
		{
			str:  "a-b-c",
			want: "ABC",
		},
		{
			str:  "---",
			want: "",
		},
	}
	for _, tt := range tests {
		t.Run(tt.str, func(t *testing.T) {
			if got := classify(tt.str); got != tt.want {
				t.Errorf("classify() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestGenerateCask(t *testing.T) {
	tests := []struct {
		name      string
		config    cfg.Config
		tag       string
		downloads []github.Download
		want      string
	}{
		{
			name: "full cask with binary and caveats",
			config: cfg.Config{
				Name:        "claude-usage-tray",
				Kind:        "cask",
				Repository:  "patrickdappollonio/claude-usage-tray",
				Description: "A menu bar application",
				AppName:     "Claude Usage Tray.app",
				CaskBinary:  true,
				Caveats:     "The app is ad-hoc signed.",
			},
			tag: "v1.2.3",
			downloads: []github.Download{
				{Filename: "claude-usage-tray_1.2.3_darwin_arm64_app.zip", URL: "https://example.com/claude-usage-tray_1.2.3_darwin_arm64_app.zip", SHA256: "hasharm64"},
				{Filename: "claude-usage-tray_1.2.3_darwin_amd64_app.zip", URL: "https://example.com/claude-usage-tray_1.2.3_darwin_amd64_app.zip", SHA256: "hashintel"},
			},
			want: `cask "claude-usage-tray" do
  version "1.2.3"
  # MacOS ARM64 builds
  on_arm do
    sha256 "hasharm64"
    url "https://example.com/claude-usage-tray_1.2.3_darwin_arm64_app.zip"
  end
  # MacOS Intel builds
  on_intel do
    sha256 "hashintel"
    url "https://example.com/claude-usage-tray_1.2.3_darwin_amd64_app.zip"
  end

  name "Claude Usage Tray"
  desc "A menu bar application"
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"

  app "Claude Usage Tray.app"
  binary "#{appdir}/Claude Usage Tray.app/Contents/MacOS/claude-usage-tray", target: "claude-usage-tray"
  caveats <<~EOS
    The app is ad-hoc signed.
  EOS
end
`,
		},
		{
			name: "explicit display name overrides derived one",
			config: cfg.Config{
				Name:        "some-app",
				Kind:        "cask",
				Repository:  "user/some-app",
				Description: "Some application",
				AppName:     "Some App.app",
				DisplayName: "Some App for macOS",
			},
			tag: "v0.1.0",
			downloads: []github.Download{
				{Filename: "some-app_0.1.0_darwin_arm64.zip", URL: "https://example.com/some-app_0.1.0_darwin_arm64.zip", SHA256: "hasharm64"},
			},
			want: `cask "some-app" do
  version "0.1.0"
  # MacOS ARM64 builds
  on_arm do
    sha256 "hasharm64"
    url "https://example.com/some-app_0.1.0_darwin_arm64.zip"
  end

  name "Some App for macOS"
  desc "Some application"
  homepage "https://github.com/user/some-app"

  app "Some App.app"
end
`,
		},
		{
			name: "minimal cask without binary or caveats",
			config: cfg.Config{
				Name:        "some-app",
				Kind:        "cask",
				Repository:  "user/some-app",
				Description: "Some application",
				AppName:     "Some App.app",
			},
			tag: "v0.1.0",
			downloads: []github.Download{
				{Filename: "some-app_0.1.0_darwin_arm64.zip", URL: "https://example.com/some-app_0.1.0_darwin_arm64.zip", SHA256: "hasharm64"},
			},
			want: `cask "some-app" do
  version "0.1.0"
  # MacOS ARM64 builds
  on_arm do
    sha256 "hasharm64"
    url "https://example.com/some-app_0.1.0_darwin_arm64.zip"
  end

  name "Some App"
  desc "Some application"
  homepage "https://github.com/user/some-app"

  app "Some App.app"
end
`,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := GenerateCask(tt.config, tt.tag, tt.downloads, nil)
			if err != nil {
				t.Fatalf("unexpected error: %v", err)
			}

			// Ignore the trailing cache comment section, which is shared
			// verbatim with the formula template and covered elsewhere.
			body, _, found := strings.Cut(got, "\n# The following cache data")
			if !found {
				t.Fatalf("expected generated cask to contain the cache comment section; got:\n%s", got)
			}

			if body != tt.want {
				t.Errorf("GenerateCask() mismatch\ngot:\n%s\nwant:\n%s", body, tt.want)
			}
		})
	}
}

func TestGenerateCask_ErrorsOnNonDarwinDownloads(t *testing.T) {
	config := cfg.Config{
		Name:        "some-app",
		Kind:        "cask",
		Repository:  "user/some-app",
		Description: "Some application",
		AppName:     "Some App.app",
	}

	downloads := []github.Download{
		{Filename: "some-app_0.1.0_darwin_arm64.zip", URL: "https://example.com/some-app_0.1.0_darwin_arm64.zip", SHA256: "hash1"},
		{Filename: "some-app_0.1.0_linux_amd64.tar.gz", URL: "https://example.com/some-app_0.1.0_linux_amd64.tar.gz", SHA256: "hash2"},
	}

	_, err := GenerateCask(config, "v0.1.0", downloads, nil)
	if err == nil {
		t.Fatal("expected error for non-darwin downloads")
	}

	if !strings.Contains(err.Error(), "some-app_0.1.0_linux_amd64.tar.gz") {
		t.Errorf("expected error to mention the offending asset; got %q", err.Error())
	}
}

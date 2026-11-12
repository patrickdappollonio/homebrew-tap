cask "claude-usage-tray" do
  version "1.0.11"
  # MacOS ARM64 builds
  on_arm do
    sha256 "648acd4d4a3826407eef0538cc5953446ab3512414c561a6679aea82bf1e7b2d"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_darwin_arm64_app.zip"
  end
  # MacOS Intel builds
  on_intel do
    sha256 "5216194213284b4cb9e35e33794d874993ea2e85240a5b060ea62524bc71d4a4"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_darwin_amd64_app.zip"
  end

  name "Claude Usage Tray"
  desc "A tiny menu bar app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"

  app "Claude Usage Tray.app"
  binary "#{appdir}/Claude Usage Tray.app/Contents/MacOS/claude-usage-tray", target: "claude-usage-tray"
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.11","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-11-12T10:48:07.534580144-05:00","assets":[{"id":738557550,"filename":"claude-usage-tray_1.0.11_darwin_amd64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_darwin_amd64_app.zip","sha256":"5216194213284b4cb9e35e33794d874993ea2e85240a5b060ea62524bc71d4a4"},{"id":738546184,"filename":"claude-usage-tray_1.0.11_darwin_arm64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_darwin_arm64_app.zip","sha256":"648acd4d4a3826407eef0538cc5953446ab3512414c561a6679aea82bf1e7b2d"}]}

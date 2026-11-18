cask "claude-usage-tray" do
  version "1.0.12"
  # MacOS ARM64 builds
  on_arm do
    sha256 "6ad68e885a55ed56f43816728dc64d84e39be48e32af37b9f51bd4e57f006678"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_darwin_arm64_app.zip"
  end
  # MacOS Intel builds
  on_intel do
    sha256 "42a93032e60c49c491cc81233e3438a4f6f9529e0995bd3de2c2315e8f49d00c"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_darwin_amd64_app.zip"
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
# TAPGEN_CACHE: {"tag":"v1.0.12","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-11-18T03:15:36.706515146-05:00","assets":[{"id":762420915,"filename":"claude-usage-tray_1.0.12_darwin_amd64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_darwin_amd64_app.zip","sha256":"42a93032e60c49c491cc81233e3438a4f6f9529e0995bd3de2c2315e8f49d00c"},{"id":762411715,"filename":"claude-usage-tray_1.0.12_darwin_arm64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_darwin_arm64_app.zip","sha256":"6ad68e885a55ed56f43816728dc64d84e39be48e32af37b9f51bd4e57f006678"}]}

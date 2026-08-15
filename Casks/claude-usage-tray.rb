cask "claude-usage-tray" do
  version "1.0.0"
  # MacOS ARM64 builds
  on_arm do
    sha256 "f767436672479ddc076e350d820cd5cac668b6a119cf990f63b64adf8fc064f1"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_darwin_arm64_app.zip"
  end
  # MacOS Intel builds
  on_intel do
    sha256 "079e928c2bae65544277cc692b938683fd0be385fb78336cdf545c2aac6cacf6"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_darwin_amd64_app.zip"
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
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-08-15T02:35:34.893072913-04:00","assets":[{"id":515406601,"filename":"claude-usage-tray_1.0.0_darwin_amd64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_darwin_amd64_app.zip","sha256":"079e928c2bae65544277cc692b938683fd0be385fb78336cdf545c2aac6cacf6"},{"id":515404859,"filename":"claude-usage-tray_1.0.0_darwin_arm64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_darwin_arm64_app.zip","sha256":"f767436672479ddc076e350d820cd5cac668b6a119cf990f63b64adf8fc064f1"}]}

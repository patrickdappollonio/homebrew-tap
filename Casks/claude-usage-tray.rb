cask "claude-usage-tray" do
  version "1.0.10"
  # MacOS ARM64 builds
  on_arm do
    sha256 "4911b6632d1e6624ec0863c1c6f0e96ae231d0c06b909871524bd05d0b056ffd"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_darwin_arm64_app.zip"
  end
  # MacOS Intel builds
  on_intel do
    sha256 "2f2dbee0aeadb40d64f687d59c350bf21c2face254363490d3c701ab90f0f3c9"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_darwin_amd64_app.zip"
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
# TAPGEN_CACHE: {"tag":"v1.0.10","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-11-01T03:49:56.639499206-05:00","assets":[{"id":697576467,"filename":"claude-usage-tray_1.0.10_darwin_amd64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_darwin_amd64_app.zip","sha256":"2f2dbee0aeadb40d64f687d59c350bf21c2face254363490d3c701ab90f0f3c9"},{"id":697606305,"filename":"claude-usage-tray_1.0.10_darwin_arm64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_darwin_arm64_app.zip","sha256":"4911b6632d1e6624ec0863c1c6f0e96ae231d0c06b909871524bd05d0b056ffd"}]}

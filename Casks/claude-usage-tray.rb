cask "claude-usage-tray" do
  version "1.0.8"
  # MacOS ARM64 builds
  on_arm do
    sha256 "0e008a2db31fc0274d0d96367053e8d5d445ebafc9721764128b13c221e47e07"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_darwin_arm64_app.zip"
  end
  # MacOS Intel builds
  on_intel do
    sha256 "d9936792ace8d027de9f2c842a08c1708c1002d2a68dc8f1a58c9e1beebfaf23"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_darwin_amd64_app.zip"
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
# TAPGEN_CACHE: {"tag":"v1.0.8","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-10-20T01:10:59.592412124-04:00","assets":[{"id":649345267,"filename":"claude-usage-tray_1.0.8_darwin_amd64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_darwin_amd64_app.zip","sha256":"d9936792ace8d027de9f2c842a08c1708c1002d2a68dc8f1a58c9e1beebfaf23"},{"id":649350683,"filename":"claude-usage-tray_1.0.8_darwin_arm64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_darwin_arm64_app.zip","sha256":"0e008a2db31fc0274d0d96367053e8d5d445ebafc9721764128b13c221e47e07"}]}

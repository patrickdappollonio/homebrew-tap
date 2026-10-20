cask "claude-usage-tray" do
  version "1.0.9"
  # MacOS ARM64 builds
  on_arm do
    sha256 "a2773a692fe293fd142663eef2390a327790c3a40039838ee65a57402b258cf0"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_darwin_arm64_app.zip"
  end
  # MacOS Intel builds
  on_intel do
    sha256 "54ceadf71763d1181f23c832f746b09ea1fab63023669acede55072fd55ba598"
    url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_darwin_amd64_app.zip"
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
# TAPGEN_CACHE: {"tag":"v1.0.9","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-10-20T05:12:45.616282483-04:00","assets":[{"id":658389033,"filename":"claude-usage-tray_1.0.9_darwin_amd64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_darwin_amd64_app.zip","sha256":"54ceadf71763d1181f23c832f746b09ea1fab63023669acede55072fd55ba598"},{"id":658388478,"filename":"claude-usage-tray_1.0.9_darwin_arm64_app.zip","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_darwin_arm64_app.zip","sha256":"a2773a692fe293fd142663eef2390a327790c3a40039838ee65a57402b258cf0"}]}

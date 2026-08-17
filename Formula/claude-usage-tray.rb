class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.1"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "dd8bc20f246acd18e96ea2bf43a2a8f18d4a2c912164404c8daa5552b690c1ae"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.1/claude-usage-tray_1.0.1_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "d951b60d8f29bd2105ca8190c45bf8b2185f1d1f5f9ffb9972c237023cede15a"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.1/claude-usage-tray_1.0.1_linux_arm64.tar.gz"
    end
  end

  def install
    bin.install "claude-usage-tray"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.1","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-08-16T21:17:07.592745882-04:00","assets":[{"id":517359451,"filename":"claude-usage-tray_1.0.1_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.1/claude-usage-tray_1.0.1_linux_amd64.tar.gz","sha256":"dd8bc20f246acd18e96ea2bf43a2a8f18d4a2c912164404c8daa5552b690c1ae"},{"id":517359531,"filename":"claude-usage-tray_1.0.1_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.1/claude-usage-tray_1.0.1_linux_arm64.tar.gz","sha256":"d951b60d8f29bd2105ca8190c45bf8b2185f1d1f5f9ffb9972c237023cede15a"}]}

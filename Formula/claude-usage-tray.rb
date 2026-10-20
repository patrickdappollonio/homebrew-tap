class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.9"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "9fd9be88d6f01d5be61a1795be04c712c8edf642436bca9171c85e0b67a82fef"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "4f425b66be25f5c9a256de22e26902bc054635621b2ae976b168f68ea989f0b1"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.9","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-10-20T05:12:45.063872081-04:00","assets":[{"id":658387448,"filename":"claude-usage-tray_1.0.9_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_linux_amd64.tar.gz","sha256":"9fd9be88d6f01d5be61a1795be04c712c8edf642436bca9171c85e0b67a82fef"},{"id":658387533,"filename":"claude-usage-tray_1.0.9_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.9/claude-usage-tray_1.0.9_linux_arm64.tar.gz","sha256":"4f425b66be25f5c9a256de22e26902bc054635621b2ae976b168f68ea989f0b1"}]}

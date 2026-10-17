class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.8"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "f5ae77a2293561dd6c677ffcf139ed21e643e2b09afe7ed419a76bca4172e8d7"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "4e4fecf2d3720ed1f6899df75bdb5bd9e010cf0cd2d7c31088494d63e04a3815"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.8","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-10-17T02:39:26.467110973-04:00","assets":[{"id":649343692,"filename":"claude-usage-tray_1.0.8_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_linux_amd64.tar.gz","sha256":"f5ae77a2293561dd6c677ffcf139ed21e643e2b09afe7ed419a76bca4172e8d7"},{"id":649343523,"filename":"claude-usage-tray_1.0.8_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.8/claude-usage-tray_1.0.8_linux_arm64.tar.gz","sha256":"4e4fecf2d3720ed1f6899df75bdb5bd9e010cf0cd2d7c31088494d63e04a3815"}]}

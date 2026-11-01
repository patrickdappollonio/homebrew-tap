class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.10"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "065bb40ac74b497e267e46dd8506f3f8e6b657f464c9adb1d0e446dcab217adf"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "9ea618be4beb0284d48f335c3f36ab5112186b99b6f4385399f8625d0247c683"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.10","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-11-01T03:49:56.245537874-05:00","assets":[{"id":697575745,"filename":"claude-usage-tray_1.0.10_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_linux_amd64.tar.gz","sha256":"065bb40ac74b497e267e46dd8506f3f8e6b657f464c9adb1d0e446dcab217adf"},{"id":697575807,"filename":"claude-usage-tray_1.0.10_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.10/claude-usage-tray_1.0.10_linux_arm64.tar.gz","sha256":"9ea618be4beb0284d48f335c3f36ab5112186b99b6f4385399f8625d0247c683"}]}

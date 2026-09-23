class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.4"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "326b107a65b09d22847c77ace87737e35ce0a45d54abd75e1f5e25f000ffaa8d"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.4/claude-usage-tray_1.0.4_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "df5ce16f0a30e768794fb6a38eab62bdeea5f1aef00a73696d0fc50cb62b8c37"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.4/claude-usage-tray_1.0.4_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.4","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-09-23T04:25:28.20908277-04:00","assets":[{"id":583321778,"filename":"claude-usage-tray_1.0.4_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.4/claude-usage-tray_1.0.4_linux_amd64.tar.gz","sha256":"326b107a65b09d22847c77ace87737e35ce0a45d54abd75e1f5e25f000ffaa8d"},{"id":583321553,"filename":"claude-usage-tray_1.0.4_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.4/claude-usage-tray_1.0.4_linux_arm64.tar.gz","sha256":"df5ce16f0a30e768794fb6a38eab62bdeea5f1aef00a73696d0fc50cb62b8c37"}]}

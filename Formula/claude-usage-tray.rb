class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.11"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "5771055c3da35ebcb7259c34e3749a1f04d35491673411959d6dccb6d455b9c8"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "f242aba901ca6bf7491a8f7b9acc7b310f15652f46a113737da853f548a4c4e9"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.11","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-11-12T10:48:06.86933265-05:00","assets":[{"id":738544596,"filename":"claude-usage-tray_1.0.11_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_linux_amd64.tar.gz","sha256":"5771055c3da35ebcb7259c34e3749a1f04d35491673411959d6dccb6d455b9c8"},{"id":738545798,"filename":"claude-usage-tray_1.0.11_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.11/claude-usage-tray_1.0.11_linux_arm64.tar.gz","sha256":"f242aba901ca6bf7491a8f7b9acc7b310f15652f46a113737da853f548a4c4e9"}]}

class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.12"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "a40a887b59a6db1d1fab68b1eb090e3573dcb9e79aa2cffa13d4ca6125aa9993"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "f9b26c2d9f5195bb25e171a775ad3b0574571fe9fbfbcd6e1ca83dbe778068d3"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.12","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-11-18T03:15:36.391271803-05:00","assets":[{"id":762389742,"filename":"claude-usage-tray_1.0.12_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_linux_amd64.tar.gz","sha256":"a40a887b59a6db1d1fab68b1eb090e3573dcb9e79aa2cffa13d4ca6125aa9993"},{"id":762390116,"filename":"claude-usage-tray_1.0.12_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.12/claude-usage-tray_1.0.12_linux_arm64.tar.gz","sha256":"f9b26c2d9f5195bb25e171a775ad3b0574571fe9fbfbcd6e1ca83dbe778068d3"}]}

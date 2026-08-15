class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.0"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "004a946e2f7582dee1e859f5ff300bb46324d1d250fd616a4c76b3c01b0c993a"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "6980d574a394958c73653931c729e29f1b3a887f7353ff72dd6daa1647f9b451"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-08-15T02:42:05.881969178-04:00","assets":[{"id":515405521,"filename":"claude-usage-tray_1.0.0_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_linux_amd64.tar.gz","sha256":"004a946e2f7582dee1e859f5ff300bb46324d1d250fd616a4c76b3c01b0c993a"},{"id":515405136,"filename":"claude-usage-tray_1.0.0_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.0/claude-usage-tray_1.0.0_linux_arm64.tar.gz","sha256":"6980d574a394958c73653931c729e29f1b3a887f7353ff72dd6daa1647f9b451"}]}

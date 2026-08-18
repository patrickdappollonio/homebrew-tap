class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.2"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "eaa42e11f40267107b64d6965b31400faa249055824f00f18ec8b53264748572"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.2/claude-usage-tray_1.0.2_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "aba4c02b31d93d09916c051b31f56ae2dcedcd1751bfa894ef5d751698120e59"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.2/claude-usage-tray_1.0.2_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.2","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-08-18T02:42:31.69180299-04:00","assets":[{"id":519035855,"filename":"claude-usage-tray_1.0.2_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.2/claude-usage-tray_1.0.2_linux_amd64.tar.gz","sha256":"eaa42e11f40267107b64d6965b31400faa249055824f00f18ec8b53264748572"},{"id":519035736,"filename":"claude-usage-tray_1.0.2_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.2/claude-usage-tray_1.0.2_linux_arm64.tar.gz","sha256":"aba4c02b31d93d09916c051b31f56ae2dcedcd1751bfa894ef5d751698120e59"}]}

class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.6"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "eb447dbb49b5e0c1e510598741bce08d2de45036bb63011b366f511785eb98b3"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.6/claude-usage-tray_1.0.6_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "5ad3f784b1b525a68b164eb83d4f4c4efc8ca8dc4dc139404fa74a132d55356f"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.6/claude-usage-tray_1.0.6_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.6","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-09-25T03:13:14.155390626-04:00","assets":[{"id":587651665,"filename":"claude-usage-tray_1.0.6_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.6/claude-usage-tray_1.0.6_linux_amd64.tar.gz","sha256":"eb447dbb49b5e0c1e510598741bce08d2de45036bb63011b366f511785eb98b3"},{"id":587651808,"filename":"claude-usage-tray_1.0.6_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.6/claude-usage-tray_1.0.6_linux_arm64.tar.gz","sha256":"5ad3f784b1b525a68b164eb83d4f4c4efc8ca8dc4dc139404fa74a132d55356f"}]}

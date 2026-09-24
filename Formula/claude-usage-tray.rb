class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.5"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "79fe3a6b3965304109f6bea7faa2ade902dba10b000b2ade60b57c6621d07e44"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.5/claude-usage-tray_1.0.5_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "8d8af70cc02177a41e3190d1bed95c9ee8fb949931cab1f1768df3be779050aa"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.5/claude-usage-tray_1.0.5_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.5","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-09-23T21:09:24.958207582-04:00","assets":[{"id":584721199,"filename":"claude-usage-tray_1.0.5_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.5/claude-usage-tray_1.0.5_linux_amd64.tar.gz","sha256":"79fe3a6b3965304109f6bea7faa2ade902dba10b000b2ade60b57c6621d07e44"},{"id":584721255,"filename":"claude-usage-tray_1.0.5_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.5/claude-usage-tray_1.0.5_linux_arm64.tar.gz","sha256":"8d8af70cc02177a41e3190d1bed95c9ee8fb949931cab1f1768df3be779050aa"}]}

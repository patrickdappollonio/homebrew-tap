class ClaudeUsageTray < Formula
  desc "A tiny tray app showing your Claude Code 5-hour and weekly usage, straight from the Claude CLI. This formula is for Linux only; on macOS, use the cask instead."
  homepage "https://github.com/patrickdappollonio/claude-usage-tray"
  version "1.0.3"
  license "MIT"
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "290bf242192f815bb3eda24e684210e8e67f798a8a9af67a24c455775a93a357"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.3/claude-usage-tray_1.0.3_linux_amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "10b500910686f5b83caa15df376a64cc94b6d488ae77da2242f8de067eaa4364"
      url "https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.3/claude-usage-tray_1.0.3_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.3","repository":"patrickdappollonio/claude-usage-tray","cached_at":"2026-09-10T06:48:15.327539873-04:00","assets":[{"id":554362795,"filename":"claude-usage-tray_1.0.3_linux_amd64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.3/claude-usage-tray_1.0.3_linux_amd64.tar.gz","sha256":"290bf242192f815bb3eda24e684210e8e67f798a8a9af67a24c455775a93a357"},{"id":554362923,"filename":"claude-usage-tray_1.0.3_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/claude-usage-tray/releases/download/v1.0.3/claude-usage-tray_1.0.3_linux_arm64.tar.gz","sha256":"10b500910686f5b83caa15df376a64cc94b6d488ae77da2242f8de067eaa4364"}]}

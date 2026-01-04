class McpNetutils < Formula
  desc "An MCP server via STDIO to query DNS and WHOIS information."
  homepage "https://github.com/patrickdappollonio/mcp-netutils"
  version "1.4.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "4c1b6eaef8d5adc3a8b2b4de2d630a18d88634d905e20b7fef24acec30a68d20"
      url "https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "5672c9b700c37deaa8e4c855aa4fb526fa80b047c698f405f5fd1ea6a685e5e6"
      url "https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "17cece2302568634ef196bea34366f4408db1e38ef40a69fac48e43722811236"
      url "https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "76a038e3117036dcbfac39fba352f0151cd3b8af049f6b15a475e18c36bc7e02"
      url "https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "8a96996e88189b5fed9c468f115e23d630818146365933c284d6ae0efb5d82d8"
      url "https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "mcp-netutils"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.4.0","repository":"patrickdappollonio/mcp-netutils","cached_at":"2026-01-03T23:51:17.405573852-05:00","assets":[{"id":336066859,"filename":"mcp-netutils_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_darwin_arm64.tar.gz","sha256":"4c1b6eaef8d5adc3a8b2b4de2d630a18d88634d905e20b7fef24acec30a68d20"},{"id":336066858,"filename":"mcp-netutils_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_darwin_x86_64.tar.gz","sha256":"5672c9b700c37deaa8e4c855aa4fb526fa80b047c698f405f5fd1ea6a685e5e6"},{"id":336066853,"filename":"mcp-netutils_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_linux_arm.tar.gz","sha256":"8a96996e88189b5fed9c468f115e23d630818146365933c284d6ae0efb5d82d8"},{"id":336066854,"filename":"mcp-netutils_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_linux_arm64.tar.gz","sha256":"76a038e3117036dcbfac39fba352f0151cd3b8af049f6b15a475e18c36bc7e02"},{"id":336066850,"filename":"mcp-netutils_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-netutils/releases/download/v1.4.0/mcp-netutils_linux_x86_64.tar.gz","sha256":"17cece2302568634ef196bea34366f4408db1e38ef40a69fac48e43722811236"}]}

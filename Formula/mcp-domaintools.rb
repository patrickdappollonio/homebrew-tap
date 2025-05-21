class McpDomaintools < Formula
  desc "An MCP server via STDIO to query DNS and WHOIS information."
  homepage "https://github.com/patrickdappollonio/mcp-domaintools"
  version "1.1.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "91f6e9211a623423e0356e7b446049e79351871f79b0f80b9848bc4d15f2d976"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.1.0/mcp-domaintools_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "38807a4f71b6f2fe00bc2d00b15a3e9ddfc963a3c747eb85f330720b9d928f3f"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.1.0/mcp-domaintools_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "28d2a9acfb31bc49ee62490606ba273d1ca3f2a1d204f653d3a06febebef6d64"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.1.0/mcp-domaintools_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "8d22a087227efffd96a914a3ee027f0e78d164875ad9e8a1a19352c23f659a7f"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.1.0/mcp-domaintools_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "ebc6c2d53db8a88f1035a503faaf06d3050247ad27503875c23fdea69f535c04"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.1.0/mcp-domaintools_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "mcp-domaintools"
  end
end

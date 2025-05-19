class McpDomaintools < Formula
  desc "An MCP server via STDIO to query DNS and WHOIS information."
  homepage "https://github.com/patrickdappollonio/mcp-domaintools"
  version "1.0.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "c31a2b9a2e2e55e079208970d5460c132052ef721c52f82b439924d014dfad92"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.0.0/mcp-domaintools_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "86e203852c9fbe25847b03329807dcc3a5ac7fcd8f6b389473d91b6a494c9ac6"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.0.0/mcp-domaintools_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "cecc63544fdd3391c9e6ad31e9ce57d81ca271caba2d78fe5b66e887f7fb78b4"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.0.0/mcp-domaintools_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "21077856443987c2e2ee6fa3dd585f94f047f65e22446d376c8f0f927467dfa4"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.0.0/mcp-domaintools_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "3ba866d8f4661f355e081a5ee1df30e54dd1502020234adda96856e0ab549ed3"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.0.0/mcp-domaintools_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "mcp-domaintools"
  end
end

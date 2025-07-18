class McpDomaintools < Formula
  desc "An MCP server via STDIO to query DNS and WHOIS information."
  homepage "https://github.com/patrickdappollonio/mcp-domaintools"
  version "1.3.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "1eef86c32ea3812340bbf06ecfe9a36b480fe9c4fdef89c790bd28cf89a3cb2e"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "0b58818edcf6aec1fb35671642cb8cb04327df503d0adbbba0cf6526d03930b0"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "576590b6a9fac7234232b2a873fc670c364246a97eada04b0ada9645510fcc0e"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "60353f145e02e2d428021b4999ef57df0500bb228e61d70d0c6d1d3700bdb35b"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "a07f5e84d882d835cf19a19bac7a969a8efdd3772c4eaf72cfa310813cef771f"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "mcp-domaintools"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.3.0","repository":"patrickdappollonio/mcp-domaintools","cached_at":"2025-07-18T16:04:19.733720495-04:00","assets":[{"id":274187109,"filename":"mcp-domaintools_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_darwin_arm64.tar.gz","sha256":"1eef86c32ea3812340bbf06ecfe9a36b480fe9c4fdef89c790bd28cf89a3cb2e"},{"id":274187111,"filename":"mcp-domaintools_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_darwin_x86_64.tar.gz","sha256":"0b58818edcf6aec1fb35671642cb8cb04327df503d0adbbba0cf6526d03930b0"},{"id":274187112,"filename":"mcp-domaintools_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_linux_arm.tar.gz","sha256":"a07f5e84d882d835cf19a19bac7a969a8efdd3772c4eaf72cfa310813cef771f"},{"id":274187120,"filename":"mcp-domaintools_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_linux_arm64.tar.gz","sha256":"60353f145e02e2d428021b4999ef57df0500bb228e61d70d0c6d1d3700bdb35b"},{"id":274187119,"filename":"mcp-domaintools_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.0/mcp-domaintools_linux_x86_64.tar.gz","sha256":"576590b6a9fac7234232b2a873fc670c364246a97eada04b0ada9645510fcc0e"}]}

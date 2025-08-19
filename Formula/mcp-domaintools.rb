class McpDomaintools < Formula
  desc "An MCP server via STDIO to query DNS and WHOIS information."
  homepage "https://github.com/patrickdappollonio/mcp-domaintools"
  version "1.3.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "38462af12a6332910c314725422681f9b83afb0fa86b24db3c66b442c140c4b7"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "d9c5aef995fb658ee3daa8476b75cc044b09de0f7d1fa6a389a5c932dd381f57"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "99fdaecfa9cb29cabe830f6a7b244e628fcb4d171d058146928c1209427af802"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "0027c5b17e7fd69fe2c71f1056bbe75f25c54fb609034eba2c8895fdc26b2ea6"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "1eae197111f1edc7d64984e8cc7186e9a6c9021c1bd8927600c6a4773fe98d64"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_linux_arm.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.3.1","repository":"patrickdappollonio/mcp-domaintools","cached_at":"2025-08-18T23:21:28.500185427-04:00","assets":[{"id":283907020,"filename":"mcp-domaintools_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_darwin_arm64.tar.gz","sha256":"38462af12a6332910c314725422681f9b83afb0fa86b24db3c66b442c140c4b7"},{"id":283907022,"filename":"mcp-domaintools_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_darwin_x86_64.tar.gz","sha256":"d9c5aef995fb658ee3daa8476b75cc044b09de0f7d1fa6a389a5c932dd381f57"},{"id":283907021,"filename":"mcp-domaintools_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_linux_arm.tar.gz","sha256":"1eae197111f1edc7d64984e8cc7186e9a6c9021c1bd8927600c6a4773fe98d64"},{"id":283907024,"filename":"mcp-domaintools_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_linux_arm64.tar.gz","sha256":"0027c5b17e7fd69fe2c71f1056bbe75f25c54fb609034eba2c8895fdc26b2ea6"},{"id":283907026,"filename":"mcp-domaintools_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.1/mcp-domaintools_linux_x86_64.tar.gz","sha256":"99fdaecfa9cb29cabe830f6a7b244e628fcb4d171d058146928c1209427af802"}]}

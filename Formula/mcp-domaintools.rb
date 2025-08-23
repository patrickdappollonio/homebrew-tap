class McpDomaintools < Formula
  desc "An MCP server via STDIO to query DNS and WHOIS information."
  homepage "https://github.com/patrickdappollonio/mcp-domaintools"
  version "1.3.2"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "3992f18fb88a05853dd9c4953e0014aead6a70b2e468a81619ae415812fac98f"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "e0cf97535bf6b972fe20a82da8bc8487b106b8b44a737ada49ef2447b3ea27c4"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "77f2adab0898b1e343fe65af6d8e85e9f162dd0b1ea16a754acdf0d82d1083a9"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "14e5cdbe563df5c927d858470c2b64b8a4bf5da107009969794578506b6a6810"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "400902fbd5cef8c15f3bde8e5d7326e913d56e87180a667a494e0854bf9165d0"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_linux_arm.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.3.2","repository":"patrickdappollonio/mcp-domaintools","cached_at":"2025-08-23T02:04:45.53026447-04:00","assets":[{"id":285390739,"filename":"mcp-domaintools_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_darwin_arm64.tar.gz","sha256":"3992f18fb88a05853dd9c4953e0014aead6a70b2e468a81619ae415812fac98f"},{"id":285390747,"filename":"mcp-domaintools_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_darwin_x86_64.tar.gz","sha256":"e0cf97535bf6b972fe20a82da8bc8487b106b8b44a737ada49ef2447b3ea27c4"},{"id":285390738,"filename":"mcp-domaintools_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_linux_arm.tar.gz","sha256":"400902fbd5cef8c15f3bde8e5d7326e913d56e87180a667a494e0854bf9165d0"},{"id":285390740,"filename":"mcp-domaintools_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_linux_arm64.tar.gz","sha256":"14e5cdbe563df5c927d858470c2b64b8a4bf5da107009969794578506b6a6810"},{"id":285390736,"filename":"mcp-domaintools_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.3.2/mcp-domaintools_linux_x86_64.tar.gz","sha256":"77f2adab0898b1e343fe65af6d8e85e9f162dd0b1ea16a754acdf0d82d1083a9"}]}

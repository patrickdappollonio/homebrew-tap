class McpDomaintools < Formula
  desc "An MCP server via STDIO to query DNS and WHOIS information."
  homepage "https://github.com/patrickdappollonio/mcp-domaintools"
  version "1.2.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "9e40252237a3aa4a1c2bdaa16b265e0f871e8565f1da6ce3a7ef85df40b80580"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "d4a344e8b9cb75ebc6add09dff862a58b0a2260b74f03857521344cc01ac8b6b"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "ced4d29ef42f76e433a995a866ac2882053f46c7677da43f2e0c4e963125d181"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_linux_arm.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "01b1e47f4783f1e816d9be255023a9580a8e797708edba8edf316df9f89d0544"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "337412ca627277e2ee13b114b34229d3d97ecb8ff792bad38dfcf1f420218908"
      url "https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.2.0","repository":"patrickdappollonio/mcp-domaintools","cached_at":"2025-07-09T00:26:12.77281716-04:00","assets":[{"id":270467943,"filename":"mcp-domaintools_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_darwin_arm64.tar.gz","sha256":"9e40252237a3aa4a1c2bdaa16b265e0f871e8565f1da6ce3a7ef85df40b80580"},{"id":270467963,"filename":"mcp-domaintools_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_darwin_x86_64.tar.gz","sha256":"d4a344e8b9cb75ebc6add09dff862a58b0a2260b74f03857521344cc01ac8b6b"},{"id":270467945,"filename":"mcp-domaintools_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_linux_arm.tar.gz","sha256":"ced4d29ef42f76e433a995a866ac2882053f46c7677da43f2e0c4e963125d181"},{"id":270467942,"filename":"mcp-domaintools_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_linux_arm64.tar.gz","sha256":"337412ca627277e2ee13b114b34229d3d97ecb8ff792bad38dfcf1f420218908"},{"id":270467957,"filename":"mcp-domaintools_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-domaintools/releases/download/v1.2.0/mcp-domaintools_linux_x86_64.tar.gz","sha256":"01b1e47f4783f1e816d9be255023a9580a8e797708edba8edf316df9f89d0544"}]}

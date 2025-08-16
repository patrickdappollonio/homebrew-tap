class McpKubernetesRo < Formula
  desc "An MCP server providing read-only access to Kubernetes clusters for AI assistants."
  homepage "https://github.com/patrickdappollonio/mcp-kubernetes-ro"
  version "1.0.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "856b1806bb96c3cdb326242227c5c0571c8012cd89e703b10be0f2c1347cc872"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "b2f1b181ea2161426bf2a61ce7be2603bb3ca6d3ebbabb292f3aac5edf694a91"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "51a0bac3c641e3435a709925dfbc603308e47e497c722b0b82bf7c3dfa94ec8d"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "491fc07b8b1ae1e5e38ed21025d0db3d512803d4f4f57b49491bcf381dfbfc21"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_linux_arm64.tar.gz"
    end
  end

  def install
    bin.install "mcp-kubernetes-ro"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.1","repository":"patrickdappollonio/mcp-kubernetes-ro","cached_at":"2025-08-16T19:03:25.975518952-04:00","assets":[{"id":283216503,"filename":"mcp-kubernetes-ro_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_darwin_arm64.tar.gz","sha256":"856b1806bb96c3cdb326242227c5c0571c8012cd89e703b10be0f2c1347cc872"},{"id":283216504,"filename":"mcp-kubernetes-ro_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_darwin_x86_64.tar.gz","sha256":"b2f1b181ea2161426bf2a61ce7be2603bb3ca6d3ebbabb292f3aac5edf694a91"},{"id":283216499,"filename":"mcp-kubernetes-ro_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_linux_arm64.tar.gz","sha256":"491fc07b8b1ae1e5e38ed21025d0db3d512803d4f4f57b49491bcf381dfbfc21"},{"id":283216502,"filename":"mcp-kubernetes-ro_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.1/mcp-kubernetes-ro_linux_x86_64.tar.gz","sha256":"51a0bac3c641e3435a709925dfbc603308e47e497c722b0b82bf7c3dfa94ec8d"}]}

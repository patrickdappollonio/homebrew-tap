class McpKubernetesRo < Formula
  desc "An MCP server providing read-only access to Kubernetes clusters for AI assistants."
  homepage "https://github.com/patrickdappollonio/mcp-kubernetes-ro"
  version "1.0.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "83abd11e1a654b627a8a5ec45320c578506c4a3961fa2036778686e1eca367c2"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "d3dc9f73a4020de6f6f836a155e7eab3705850d4e0a85a66887e21b2a39ebda1"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "185dc9c7d7aa17b3f700b7cd986747be7d5c0882dfea379a7fa6ae087a979cc2"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "3acf83cd2a38f38417d9529ed9a05ad02fc1701f22bb0182014109191cc7ec7d"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/mcp-kubernetes-ro","cached_at":"2025-07-12T16:24:23.200475126-04:00","assets":[{"id":272315475,"filename":"mcp-kubernetes-ro_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz","sha256":"83abd11e1a654b627a8a5ec45320c578506c4a3961fa2036778686e1eca367c2"},{"id":272315473,"filename":"mcp-kubernetes-ro_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz","sha256":"d3dc9f73a4020de6f6f836a155e7eab3705850d4e0a85a66887e21b2a39ebda1"},{"id":272315476,"filename":"mcp-kubernetes-ro_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_arm64.tar.gz","sha256":"3acf83cd2a38f38417d9529ed9a05ad02fc1701f22bb0182014109191cc7ec7d"},{"id":272315480,"filename":"mcp-kubernetes-ro_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz","sha256":"185dc9c7d7aa17b3f700b7cd986747be7d5c0882dfea379a7fa6ae087a979cc2"}]}

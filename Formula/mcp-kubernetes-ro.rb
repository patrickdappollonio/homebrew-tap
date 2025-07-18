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
      sha256 "195c0f8817a48885e1251e966f67c061ccc86b875a59ac4fba0f8f8fa1a05801"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "c74fa5399442d3b0e0580d4f309fdee647d7bc2b6069896b962c95ada4a27cd9"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "15b2f71caf274b52d520de5afd610e54c36f1d62bcc5ae61fb265031e06ccfde"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "c9dbc8c86a50d60f088706fbf3368d7bb39f294559afff7d0ce5f9ef40f01eee"
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
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/mcp-kubernetes-ro","cached_at":"2025-07-17T22:41:30.237684691-04:00","assets":[{"id":273980557,"filename":"mcp-kubernetes-ro_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz","sha256":"195c0f8817a48885e1251e966f67c061ccc86b875a59ac4fba0f8f8fa1a05801"},{"id":273980568,"filename":"mcp-kubernetes-ro_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz","sha256":"c74fa5399442d3b0e0580d4f309fdee647d7bc2b6069896b962c95ada4a27cd9"},{"id":273980556,"filename":"mcp-kubernetes-ro_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_arm64.tar.gz","sha256":"c9dbc8c86a50d60f088706fbf3368d7bb39f294559afff7d0ce5f9ef40f01eee"},{"id":273980555,"filename":"mcp-kubernetes-ro_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz","sha256":"15b2f71caf274b52d520de5afd610e54c36f1d62bcc5ae61fb265031e06ccfde"}]}

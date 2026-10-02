class McpKubernetesRo < Formula
  desc "An MCP server providing read-only access to Kubernetes clusters for AI assistants."
  homepage "https://github.com/patrickdappollonio/mcp-kubernetes-ro"
  version "1.1.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "77568bd2a59f046b97f0c9d5d553a6a40416f690230b788bdb14a8064270b126"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "4d24a6cc5c15ee31eaa18db4e13c623810662b0b3a07ba6aff045b8d2450f046"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "97fab215a68b38efda03db1fdc35b0db7d45905b22ef4ae68efccdc80a837dbf"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "f8536e06a9f417eb5b20fdac0eb55e17b01ea682a8a4573975cfd77a2a0f090b"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.1.0","repository":"patrickdappollonio/mcp-kubernetes-ro","cached_at":"2026-10-02T04:00:56.59136107-04:00","assets":[{"id":604967764,"filename":"mcp-kubernetes-ro_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_darwin_arm64.tar.gz","sha256":"77568bd2a59f046b97f0c9d5d553a6a40416f690230b788bdb14a8064270b126"},{"id":604967802,"filename":"mcp-kubernetes-ro_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz","sha256":"4d24a6cc5c15ee31eaa18db4e13c623810662b0b3a07ba6aff045b8d2450f046"},{"id":604967761,"filename":"mcp-kubernetes-ro_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_linux_arm64.tar.gz","sha256":"f8536e06a9f417eb5b20fdac0eb55e17b01ea682a8a4573975cfd77a2a0f090b"},{"id":604967762,"filename":"mcp-kubernetes-ro_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.1.0/mcp-kubernetes-ro_linux_x86_64.tar.gz","sha256":"97fab215a68b38efda03db1fdc35b0db7d45905b22ef4ae68efccdc80a837dbf"}]}

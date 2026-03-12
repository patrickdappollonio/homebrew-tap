class McpKubernetesRo < Formula
  desc "An MCP server providing read-only access to Kubernetes clusters for AI assistants."
  homepage "https://github.com/patrickdappollonio/mcp-kubernetes-ro"
  version "1.0.2"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "7204b8cd4584bb568dfad5741a2e476278a0b4c523709709ff6cc9ff9bf6f58c"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "d961114807fd30dc60d896334897cdd182cdf3aad93ad27ad46d11e6c21c4e84"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "16c8776936d645035bd4675bd7f47c0fdf8b96c58dca44d05b191ed3ebdc26ce"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "489ed61af354dfb8f2df4272400860297458378bf106b689e1f064dd28c2fcb3"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.0.2","repository":"patrickdappollonio/mcp-kubernetes-ro","cached_at":"2026-03-11T20:27:57.693545478-04:00","assets":[{"id":371909091,"filename":"mcp-kubernetes-ro_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_darwin_arm64.tar.gz","sha256":"7204b8cd4584bb568dfad5741a2e476278a0b4c523709709ff6cc9ff9bf6f58c"},{"id":371909093,"filename":"mcp-kubernetes-ro_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_darwin_x86_64.tar.gz","sha256":"d961114807fd30dc60d896334897cdd182cdf3aad93ad27ad46d11e6c21c4e84"},{"id":371909080,"filename":"mcp-kubernetes-ro_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_linux_arm64.tar.gz","sha256":"489ed61af354dfb8f2df4272400860297458378bf106b689e1f064dd28c2fcb3"},{"id":371909078,"filename":"mcp-kubernetes-ro_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.2/mcp-kubernetes-ro_linux_x86_64.tar.gz","sha256":"16c8776936d645035bd4675bd7f47c0fdf8b96c58dca44d05b191ed3ebdc26ce"}]}

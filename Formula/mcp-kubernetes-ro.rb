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
      sha256 "cd4535770d0c05f4f7df4cab03eb7f2aaf4284c2f7b5cb40970f33fa4f3994a5"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "5ca35092bb956eb50e87e096e4bbb75980ba2d5df16d8e8df8241e9174dfa6ca"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "9235ea0d64837d490b3691e24b715f2572495a9ba7e51294198b35a72bff80d1"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "2b22a9360eb8fdd621d34322689640962b187334887e62493677fae1b3361feb"
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
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/mcp-kubernetes-ro","cached_at":"2025-07-18T01:08:18.276016607-04:00","assets":[{"id":274012927,"filename":"mcp-kubernetes-ro_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz","sha256":"cd4535770d0c05f4f7df4cab03eb7f2aaf4284c2f7b5cb40970f33fa4f3994a5"},{"id":274012928,"filename":"mcp-kubernetes-ro_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz","sha256":"5ca35092bb956eb50e87e096e4bbb75980ba2d5df16d8e8df8241e9174dfa6ca"},{"id":274012932,"filename":"mcp-kubernetes-ro_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_arm64.tar.gz","sha256":"2b22a9360eb8fdd621d34322689640962b187334887e62493677fae1b3361feb"},{"id":274012929,"filename":"mcp-kubernetes-ro_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz","sha256":"9235ea0d64837d490b3691e24b715f2572495a9ba7e51294198b35a72bff80d1"}]}

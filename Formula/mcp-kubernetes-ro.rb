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
      sha256 "1f09b44d0078db3eb872eecface52c386cb90e37f03c5c9320109308777289e7"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "ffe2be5692ae8a14b29f8b4eeb4141064e03649525799cbc4cd62aec1258a427"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "0cde33c37c6f1c10024e1894e5c1fc9c5b043467f6907a0c49df832c03c548de"
      url "https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "95f152ee13c1233e075c38e12b6f5d26b8d381b76924790f826d648535c559ca"
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
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/mcp-kubernetes-ro","cached_at":"2025-07-18T18:24:50.398512395-04:00","assets":[{"id":274220598,"filename":"mcp-kubernetes-ro_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_arm64.tar.gz","sha256":"1f09b44d0078db3eb872eecface52c386cb90e37f03c5c9320109308777289e7"},{"id":274220607,"filename":"mcp-kubernetes-ro_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_darwin_x86_64.tar.gz","sha256":"ffe2be5692ae8a14b29f8b4eeb4141064e03649525799cbc4cd62aec1258a427"},{"id":274220602,"filename":"mcp-kubernetes-ro_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_arm64.tar.gz","sha256":"95f152ee13c1233e075c38e12b6f5d26b8d381b76924790f826d648535c559ca"},{"id":274220599,"filename":"mcp-kubernetes-ro_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mcp-kubernetes-ro/releases/download/v1.0.0/mcp-kubernetes-ro_linux_x86_64.tar.gz","sha256":"0cde33c37c6f1c10024e1894e5c1fc9c5b043467f6907a0c49df832c03c548de"}]}

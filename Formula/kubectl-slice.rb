class KubectlSlice < Formula
  desc "Split multiple Kubernetes files into smaller files with ease. Split multi-YAML files into individual files."
  homepage "https://github.com/patrickdappollonio/kubectl-slice"
  version "1.4.2"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "46dbfdb8635a015b9352d78b8865fd19ca10fd30933dc74ffbd208ace371033e"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "90c1d2013bcf8ca71a0307da932e2d4ee2ad58578076256a8a4ded842291648a"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "f486606fe4fb936644c56ec087342b212215162599bd8b9b896e8c3ebc658c56"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "869d685033c4b186b5d5175b67a18c138e0117173b8713387038701486fb5737"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "f5d99615ea4eafe4ff9e9258957753d3081e3f123d7c8818506b30c267060c22"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "kubectl-slice"
  end
  test do
    system "#{bin}/kubectl-slice -v"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.4.2","repository":"patrickdappollonio/kubectl-slice","cached_at":"2025-07-09T00:24:31.876752892-04:00","assets":[{"id":236309686,"filename":"kubectl-slice_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_darwin_arm64.tar.gz","sha256":"46dbfdb8635a015b9352d78b8865fd19ca10fd30933dc74ffbd208ace371033e"},{"id":236309685,"filename":"kubectl-slice_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_darwin_x86_64.tar.gz","sha256":"90c1d2013bcf8ca71a0307da932e2d4ee2ad58578076256a8a4ded842291648a"},{"id":236309684,"filename":"kubectl-slice_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_linux_arm.tar.gz","sha256":"f486606fe4fb936644c56ec087342b212215162599bd8b9b896e8c3ebc658c56"},{"id":236309677,"filename":"kubectl-slice_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_linux_arm64.tar.gz","sha256":"869d685033c4b186b5d5175b67a18c138e0117173b8713387038701486fb5737"},{"id":236309679,"filename":"kubectl-slice_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.2/kubectl-slice_linux_x86_64.tar.gz","sha256":"f5d99615ea4eafe4ff9e9258957753d3081e3f123d7c8818506b30c267060c22"}]}

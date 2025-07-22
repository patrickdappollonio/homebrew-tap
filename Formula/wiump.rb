class Wiump < Formula
  desc "Who is using my port? A simple application to tell you what app is using your port."
  homepage "https://github.com/patrickdappollonio/wiump"
  version "1.1.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "3e6bbbe90ac3d3c62cffe7048643af422fc1f2db4625337a7b8b762d0e716020"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "f1b7119ff72eb08bfbef09bdd4e2e7d109da2229491fd7f5eb83f9755126e550"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "4d4d34e41615500ca0ef1a7dc0cf0e54c00e7570eed1f8fa466445d6e034b7f8"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-linux-x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "a40d790f7734419e4b06a6c5bd8b6d19445f81c4d1327ded379e729afe0dc9bf"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-linux-arm64.tar.gz"
    end
  end

  def install
    bin.install "wiump"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.1.0","repository":"patrickdappollonio/wiump","cached_at":"2025-07-22T03:06:12.360457691-04:00","assets":[{"id":275168116,"filename":"wiump-v1.1.0-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-darwin-arm64.tar.gz","sha256":"3e6bbbe90ac3d3c62cffe7048643af422fc1f2db4625337a7b8b762d0e716020"},{"id":275168124,"filename":"wiump-v1.1.0-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-darwin-x86_64.tar.gz","sha256":"f1b7119ff72eb08bfbef09bdd4e2e7d109da2229491fd7f5eb83f9755126e550"},{"id":275168227,"filename":"wiump-v1.1.0-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-linux-arm64.tar.gz","sha256":"a40d790f7734419e4b06a6c5bd8b6d19445f81c4d1327ded379e729afe0dc9bf"},{"id":275168125,"filename":"wiump-v1.1.0-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.0/wiump-v1.1.0-linux-x86_64.tar.gz","sha256":"4d4d34e41615500ca0ef1a7dc0cf0e54c00e7570eed1f8fa466445d6e034b7f8"}]}

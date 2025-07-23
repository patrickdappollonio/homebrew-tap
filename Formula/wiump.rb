class Wiump < Formula
  desc "Who is using my port? A simple application to tell you what app is using your port."
  homepage "https://github.com/patrickdappollonio/wiump"
  version "1.1.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "69a005b4cc2d9c5d78df2d3216dad058311d97c3e9dae3e1107830fa7384a6a9"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "8d91feec33074321e7d9c50e0a4aea314f3aa2921a555899f6d5bcdc0d67ed15"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "e325fffb1de9891e9947b3390daf8c95bca2b5b02de59dde6b0d9d09b4f3b70b"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-linux-x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "40168e93ff22156795ea99f97365153c68dbff479c04f0546f6c305054264465"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.1.1","repository":"patrickdappollonio/wiump","cached_at":"2025-07-23T02:06:02.745722541-04:00","assets":[{"id":275490853,"filename":"wiump-v1.1.1-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-darwin-arm64.tar.gz","sha256":"69a005b4cc2d9c5d78df2d3216dad058311d97c3e9dae3e1107830fa7384a6a9"},{"id":275490862,"filename":"wiump-v1.1.1-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-darwin-x86_64.tar.gz","sha256":"8d91feec33074321e7d9c50e0a4aea314f3aa2921a555899f6d5bcdc0d67ed15"},{"id":275490988,"filename":"wiump-v1.1.1-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-linux-arm64.tar.gz","sha256":"40168e93ff22156795ea99f97365153c68dbff479c04f0546f6c305054264465"},{"id":275490888,"filename":"wiump-v1.1.1-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wiump/releases/download/v1.1.1/wiump-v1.1.1-linux-x86_64.tar.gz","sha256":"e325fffb1de9891e9947b3390daf8c95bca2b5b02de59dde6b0d9d09b4f3b70b"}]}

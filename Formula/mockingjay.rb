class Mockingjay < Formula
  desc "A YAML-configurable HTTP server that uses Go templates to create dynamic mock APIs with regex routing, middleware support, and 100+ helper functions."
  homepage "https://github.com/patrickdappollonio/mockingjay"
  version "1.0.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "5a9a39757a8778d1ce53485b6e1db66bf1a8ed88beebe4f3ec7bacf64ae938e0"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "6b7512c8943cfddf753550efb7b2565767c56fab46d8f426ffaa00dabfda78f6"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "88724a5557c2cddf4e468e072bdbdac9588ed17503d026abcf69aa439d650267"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "e1360f42590898f3e7d6d356daed60b97e04b4670214230f531ad5d099f312f9"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "6257123aa7a23cda265e1e0fd85c71420d25697a0774341564cb1726a6b1c07a"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "mockingjay"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/mockingjay","cached_at":"2025-08-08T01:51:19.955276747-04:00","assets":[{"id":280534916,"filename":"mockingjay_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_darwin_arm64.tar.gz","sha256":"5a9a39757a8778d1ce53485b6e1db66bf1a8ed88beebe4f3ec7bacf64ae938e0"},{"id":280534918,"filename":"mockingjay_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_darwin_x86_64.tar.gz","sha256":"6b7512c8943cfddf753550efb7b2565767c56fab46d8f426ffaa00dabfda78f6"},{"id":280534912,"filename":"mockingjay_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_linux_arm.tar.gz","sha256":"6257123aa7a23cda265e1e0fd85c71420d25697a0774341564cb1726a6b1c07a"},{"id":280534911,"filename":"mockingjay_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_linux_arm64.tar.gz","sha256":"e1360f42590898f3e7d6d356daed60b97e04b4670214230f531ad5d099f312f9"},{"id":280534910,"filename":"mockingjay_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.0/mockingjay_linux_x86_64.tar.gz","sha256":"88724a5557c2cddf4e468e072bdbdac9588ed17503d026abcf69aa439d650267"}]}

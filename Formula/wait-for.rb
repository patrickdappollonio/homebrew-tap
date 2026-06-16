class WaitFor < Formula
  desc "A small, zero dependencies app that can be used as an init container to ping resources and check if they're available."
  homepage "https://github.com/patrickdappollonio/wait-for"
  version "1.2.4"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "98fe49ed6146c4cb2026d916ede81176998a84fdf862ea8ebc59c0afa218071e"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "f3eac7444b68770aab4956cc57b94ec999a310a80745b981e3c6465412f7f950"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "3af142cceeeafe382a522e3485da19ebb7cdef0624ed0c410b5abc6b7ab46e0f"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "a6ecd0d42c8259c739545ce31a031bbbfb3b601cce4280b50cea8ec57709ca60"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "fcc34b7b46f5d7e5024dd853f817fe0014d3b4cb459f4b3e3b0952f0072cc332"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "wait-for"
  end
  test do
    system "#{bin}/wait-for --version"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.2.4","repository":"patrickdappollonio/wait-for","cached_at":"2026-06-16T16:04:51.653503353-04:00","assets":[{"id":449530017,"filename":"wait-for_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_darwin_arm64.tar.gz","sha256":"98fe49ed6146c4cb2026d916ede81176998a84fdf862ea8ebc59c0afa218071e"},{"id":449530019,"filename":"wait-for_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_darwin_x86_64.tar.gz","sha256":"f3eac7444b68770aab4956cc57b94ec999a310a80745b981e3c6465412f7f950"},{"id":449530018,"filename":"wait-for_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_linux_arm.tar.gz","sha256":"fcc34b7b46f5d7e5024dd853f817fe0014d3b4cb459f4b3e3b0952f0072cc332"},{"id":449530028,"filename":"wait-for_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_linux_arm64.tar.gz","sha256":"a6ecd0d42c8259c739545ce31a031bbbfb3b601cce4280b50cea8ec57709ca60"},{"id":449530021,"filename":"wait-for_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.4/wait-for_linux_x86_64.tar.gz","sha256":"3af142cceeeafe382a522e3485da19ebb7cdef0624ed0c410b5abc6b7ab46e0f"}]}

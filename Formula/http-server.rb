class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.10.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "1edf44f438c8d2213eb476318a11bc8723240f6db098b072f17b510ad5a790ca"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "dc611aadbff724e11bd14bf60f9674c58e8c73d1d507dc04840f4e3a98903849"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "4cc7a8d3ab49cf9303bc2303d92a61e7380d3aa2d8597a64e35cc625e8e7f682"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "1dbe4bd524850694fea0183b61bbc9dabc88fb05e9b26fb77dd14179502ad63c"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "eece88091a66ec9d310dd2d82e9e01470d4a9522391729d45437e2fb921fdea0"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v2.10.0","repository":"patrickdappollonio/http-server","cached_at":"2026-03-23T00:48:06.42372267-04:00","assets":[{"id":379489437,"filename":"http-server_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_darwin_arm64.tar.gz","sha256":"1edf44f438c8d2213eb476318a11bc8723240f6db098b072f17b510ad5a790ca"},{"id":379489438,"filename":"http-server_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_darwin_x86_64.tar.gz","sha256":"dc611aadbff724e11bd14bf60f9674c58e8c73d1d507dc04840f4e3a98903849"},{"id":379489431,"filename":"http-server_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_linux_arm.tar.gz","sha256":"eece88091a66ec9d310dd2d82e9e01470d4a9522391729d45437e2fb921fdea0"},{"id":379489430,"filename":"http-server_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_linux_arm64.tar.gz","sha256":"1dbe4bd524850694fea0183b61bbc9dabc88fb05e9b26fb77dd14179502ad63c"},{"id":379489432,"filename":"http-server_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.0/http-server_linux_x86_64.tar.gz","sha256":"4cc7a8d3ab49cf9303bc2303d92a61e7380d3aa2d8597a64e35cc625e8e7f682"}]}

class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.9.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "d55f521271114b3f6ce379f2a5890fda6fb687340202c2e171bed2bdfed215a1"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "05a6567a58df8cf1a8c2cab8a7ff702c52508c20b847e7bdc8ea98f7b7eab679"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "4c46b19489841214cd1b6990b984c99a20dd9d2d0b1dbcef5b6243f68c985239"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "e8b24e42d131b312a3ce5f96841bf9a0a12598603b3594dda95d4ff3f788f10d"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "b74d2da3c8ab684d0f83fec4967f285eb9daabcc44983345d997a5fa3c6753b9"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_linux_arm.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v2.9.0","repository":"patrickdappollonio/http-server","cached_at":"2025-07-09T00:25:57.435984983-04:00","assets":[{"id":256400145,"filename":"http-server_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_darwin_arm64.tar.gz","sha256":"d55f521271114b3f6ce379f2a5890fda6fb687340202c2e171bed2bdfed215a1"},{"id":256400135,"filename":"http-server_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_darwin_x86_64.tar.gz","sha256":"05a6567a58df8cf1a8c2cab8a7ff702c52508c20b847e7bdc8ea98f7b7eab679"},{"id":256400142,"filename":"http-server_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_linux_arm.tar.gz","sha256":"b74d2da3c8ab684d0f83fec4967f285eb9daabcc44983345d997a5fa3c6753b9"},{"id":256400144,"filename":"http-server_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_linux_arm64.tar.gz","sha256":"e8b24e42d131b312a3ce5f96841bf9a0a12598603b3594dda95d4ff3f788f10d"},{"id":256400138,"filename":"http-server_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.0/http-server_linux_x86_64.tar.gz","sha256":"4c46b19489841214cd1b6990b984c99a20dd9d2d0b1dbcef5b6243f68c985239"}]}

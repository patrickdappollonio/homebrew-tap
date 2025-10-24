class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.9.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "ba9731324b37a427cd2a5d94108472d1d4820eca502537740fedeb860f5368e4"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "f9c089a7972b7dce185cb27ae448f726c40c88cdc3a4328649e4a7f1d2f1fdbe"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "ba63c5afa3cdc47db228003c9274f9fa6d25853750020d483b470285145ccf36"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "c973b1c22a01bfa989a347b5befc7689cc46aaad92748a07317e079567a85e00"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "50998366c64494093308614dcce11ad2410897a6fd3d5c862f943ef87d60e155"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_linux_arm.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v2.9.1","repository":"patrickdappollonio/http-server","cached_at":"2025-10-24T04:05:22.132880645-04:00","assets":[{"id":308105752,"filename":"http-server_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_darwin_arm64.tar.gz","sha256":"ba9731324b37a427cd2a5d94108472d1d4820eca502537740fedeb860f5368e4"},{"id":308105749,"filename":"http-server_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_darwin_x86_64.tar.gz","sha256":"f9c089a7972b7dce185cb27ae448f726c40c88cdc3a4328649e4a7f1d2f1fdbe"},{"id":308105754,"filename":"http-server_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_linux_arm.tar.gz","sha256":"50998366c64494093308614dcce11ad2410897a6fd3d5c862f943ef87d60e155"},{"id":308105757,"filename":"http-server_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_linux_arm64.tar.gz","sha256":"c973b1c22a01bfa989a347b5befc7689cc46aaad92748a07317e079567a85e00"},{"id":308105761,"filename":"http-server_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.9.1/http-server_linux_x86_64.tar.gz","sha256":"ba63c5afa3cdc47db228003c9274f9fa6d25853750020d483b470285145ccf36"}]}

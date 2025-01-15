class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.5.2"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "9b3874094ca3fb381a96959dcaa93b1719cb32e67e621780a8ed166edfc2b306"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "0ccf88158f4ea6832fd38d3de5f96bf1303e70760c8a2efd9d25d9cff06e9c8e"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "e17bad6f010dd1cb45107047009406e679e9264787355d943b4ca11256a10e53"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "0424fe6ee17a7e1e7472bb6d090acabd478f66d0cf82377b9992022674da8556"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "a19819b75f5d3b570786bc15c696796979b283930fe702e85c8b52766b46dbcb"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

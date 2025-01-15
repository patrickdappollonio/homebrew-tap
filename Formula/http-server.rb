class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.5.2"
  on_macos do
    if Hardware::CPU.arm?
      sha256 "9b3874094ca3fb381a96959dcaa93b1719cb32e67e621780a8ed166edfc2b306"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_darwin_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "0ccf88158f4ea6832fd38d3de5f96bf1303e70760c8a2efd9d25d9cff06e9c8e"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_darwin_x86_64.tar.gz"
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      sha256 "0424fe6ee17a7e1e7472bb6d090acabd478f66d0cf82377b9992022674da8556"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_linux_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "a19819b75f5d3b570786bc15c696796979b283930fe702e85c8b52766b46dbcb"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.2/http-server_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

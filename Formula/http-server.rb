class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.8.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "cee222fe3566f0e85f832ee3563ee0fa8b7fe91f4dbf74300bd01f811469bb65"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.0/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "e2782ad078e1edd4cf738eca2e36123de5147ab61d7aef67f824d9a80b59757f"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.0/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "166c076bda66d943841d79604a4d8aea03222b6bda2cf93719604329ad9e4528"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.0/http-server_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "a4bddfe0070d4bbdecdeba981fccdd06fa7aa05203b4cb4c2dbded0d3c0faffd"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.0/http-server_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "7344241e0d28a10954b69b0e602ff66b434c615ce5e134c7d836d6cca79b9c12"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.0/http-server_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.5.3"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "064f6cec8f49cf5f1855cd0b2db5ff726f6915e7b6058f4a3564ac5adc087f17"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.3/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "1049687a78f43e31aa74fd1c985d3186389a8339850f7e90d1f301777b00b3e0"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.3/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "e952ef5c162f6b6fe6ef754d50d6949a80ec89bbaf1f8a3005567cc44183d964"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.3/http-server_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "decf53500f4333d0245b8b23a8a726f44cf916027d5c80200f760938ba34e026"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.3/http-server_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "db84f25bc63225154c4f6e5543075bb16c76452ac525fcf1bcabbf8d23ce9a38"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.5.3/http-server_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

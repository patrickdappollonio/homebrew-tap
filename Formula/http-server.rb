class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.6.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "5a563d0c04f41b9bb773400b0c480d852d2f65c4b945ae66e2eec74be0602dd5"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.6.0/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "463252abf9c71990216e33c7c9e6ae64b04b17dbfd116699d0f1347115b6e4f6"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.6.0/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "e5059e072d8d1c07a8b590aa819ccd9e287de434e6c4ef06889f3becf39e159e"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.6.0/http-server_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "11049200926c2ffbf554baf68d9668deaadf3cd550c37860d2ed30c0d8d1bba3"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.6.0/http-server_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "28deafbcfaca8e5d165985f11a7b25102c7ead58e18fdcc94281fc85bcab9a56"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.6.0/http-server_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

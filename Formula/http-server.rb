class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.7.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "0978c60470e26a5c6b72834968235b2dc7a850c5091273122bfce9069bab523f"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.7.0/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "7a3292618272c27febb5c656cc6edb68844fc9955c9e1bf14efef2df9f8675ac"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.7.0/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "b6d0424117492883c223919ca08d6ab0ab37328cc3ee7e32ffff1b0b18a2a8d9"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.7.0/http-server_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "a093d4c630b0e9673795ff5f8c942cedbb4840346e0fcd9cb798d29dbe8b2471"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.7.0/http-server_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "89a424c46c15b23e66e4bb8980a756329357bff811a3d64f5e61138cc263e526"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.7.0/http-server_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

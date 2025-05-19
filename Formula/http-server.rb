class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.8.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "791aebe91cf4083d91beabee3603ad41024be7a2a6f7e681764ebced8d1f08f3"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.1/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "1497d7385d2958b8acccf740477746ebceb6929af71b82c986c6b48219a2322d"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.1/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "70cc8312873155428839b7a77b52fb4da0479da1e2f52679126b26b18e8df93d"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.1/http-server_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "273c945a4f260c344744abbcab13495b33ac2ad7a0621d78711df77845759ce2"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.1/http-server_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "e74c5fcdf1d9d1a1838deae81f32dc3250eb1a883fdc24a3c596f3753e23fe20"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.8.1/http-server_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "http-server"
  end
end

class HttpServer < Formula
  desc "A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer."
  homepage "https://www.httpserver.app"
  version "2.10.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "12e8e82b217d3b07456497fbc9e3449b501727afdff953bfbc1d3e0ccebd3860"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "4ae72ae2966f78ae5626dd0cbd4471e1688cf734ecfa281a008bfa539ca87b70"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "abfde9ea9c24804cd12167dc5a263aa342c28324d836c5164b6bb1eb7b5a4cc3"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "a7cf67608965ce39902e270f9926df7d759f26ff1bc06df470f768ceda6adaed"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "5b0efb35f4b28a012811e24dbd4284ab912fdadde463a24c688cf4994153e35a"
      url "https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_linux_arm.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v2.10.1","repository":"patrickdappollonio/http-server","cached_at":"2026-04-20T01:07:05.717972987-04:00","assets":[{"id":400364161,"filename":"http-server_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_darwin_arm64.tar.gz","sha256":"12e8e82b217d3b07456497fbc9e3449b501727afdff953bfbc1d3e0ccebd3860"},{"id":400364128,"filename":"http-server_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_darwin_x86_64.tar.gz","sha256":"4ae72ae2966f78ae5626dd0cbd4471e1688cf734ecfa281a008bfa539ca87b70"},{"id":400364138,"filename":"http-server_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_linux_arm.tar.gz","sha256":"5b0efb35f4b28a012811e24dbd4284ab912fdadde463a24c688cf4994153e35a"},{"id":400364129,"filename":"http-server_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_linux_arm64.tar.gz","sha256":"a7cf67608965ce39902e270f9926df7d759f26ff1bc06df470f768ceda6adaed"},{"id":400364130,"filename":"http-server_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/http-server/releases/download/v2.10.1/http-server_linux_x86_64.tar.gz","sha256":"abfde9ea9c24804cd12167dc5a263aa342c28324d836c5164b6bb1eb7b5a4cc3"}]}

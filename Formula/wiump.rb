class Wiump < Formula
  desc "Who is using my port? A simple application to tell you what app is using your port."
  homepage "https://github.com/patrickdappollonio/wiump"
  version "1.0.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "64bed7203cbd13f36177f6644526b3c0acb4c9de2af77ae918de2feaa2ad86e2"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.0.0/wiump-v1.0.0-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "d9f31cfe95e4983fab986d9f4c469270a9d37a826f0887469a3520f440d40178"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.0.0/wiump-v1.0.0-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "360bff46aadf7a21b12f8a4ed3018c8ac100af97fa196c6464e9d57084ca7357"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.0.0/wiump-v1.0.0-linux-arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "02bc7bd763b73213b38f795ffaf831760f29b995d233281e675c8acb5292f4f4"
      url "https://github.com/patrickdappollonio/wiump/releases/download/v1.0.0/wiump-v1.0.0-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "wiump"
  end
end

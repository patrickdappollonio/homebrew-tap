class Dotenv < Formula
  desc "An app to call other apps using customized environment variables."
  homepage "https://github.com/patrickdappollonio/dotenv"
  version "2.1.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "32d427978494337f518dba37c5932746fe812154db80f4593cd2ca08b7933812"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "d6e5b932fc7655ebe5f9f190039c8f6afe0aa0ce4cf9153b1d5c2fb3e301889d"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "d11eb16b6f30cad2da4c1b17c35f338f41c8b3fa389f4e2645e5c1ddc91896f0"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-linux-x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "76e4995a795bdfddb29e6cbc47f614fce18e9e69cf38e9e0db645845e0149ed9"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-linux-arm64.tar.gz"
    end
  end

  def install
    bin.install "dotenv"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v2.1.0","repository":"patrickdappollonio/dotenv","cached_at":"2025-07-11T21:32:23.332898006-04:00","assets":[{"id":272160823,"filename":"dotenv-v2.1.0-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-darwin-arm64.tar.gz","sha256":"32d427978494337f518dba37c5932746fe812154db80f4593cd2ca08b7933812"},{"id":272160872,"filename":"dotenv-v2.1.0-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-darwin-x86_64.tar.gz","sha256":"d6e5b932fc7655ebe5f9f190039c8f6afe0aa0ce4cf9153b1d5c2fb3e301889d"},{"id":272160977,"filename":"dotenv-v2.1.0-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-linux-arm64.tar.gz","sha256":"76e4995a795bdfddb29e6cbc47f614fce18e9e69cf38e9e0db645845e0149ed9"},{"id":272161029,"filename":"dotenv-v2.1.0-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/dotenv/releases/download/v2.1.0/dotenv-v2.1.0-linux-x86_64.tar.gz","sha256":"d11eb16b6f30cad2da4c1b17c35f338f41c8b3fa389f4e2645e5c1ddc91896f0"}]}

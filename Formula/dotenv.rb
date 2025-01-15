class Dotenv < Formula
  desc "An app to call other apps using customized environment variables."
  homepage "https://github.com/patrickdappollonio/dotenv"
  version "2.0.3"
  on_macos do
    if Hardware::CPU.arm?
      sha256 "44c08d992bbfddfc59653676c40c043986f682b5a08d3f8877c9de6cac3177a2"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.0.3/dotenv-v2.0.3-darwin-arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "d9a955021dfaf0904b0a2ce498aa19b124fd1018ea18a68373aa874c17cdcdd5"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.0.3/dotenv-v2.0.3-darwin-x86_64.tar.gz"
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      sha256 "4e1cb2576129232f04b09252c51151dd877d461c095eb9d31e80f0b60660e959"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.0.3/dotenv-v2.0.3-linux-arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "f32812c2bbbb71e5f4c65896bbd7a88947a5ff356ae4cad96f0daf7dcf71acc5"
      url "https://github.com/patrickdappollonio/dotenv/releases/download/v2.0.3/dotenv-v2.0.3-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "dotenv"
  end
end

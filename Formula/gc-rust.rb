class GcRust < Formula
  desc "Clone GitHub repositories like a champ!"
  homepage "https://github.com/patrickdappollonio/gc-rust"
  version "0.1.2"

  if Hardware::CPU.intel?
    sha256 "aa9767fd4fc868af6fdad3ecbd8c493d73d189ad77bb7ac10a1a3e94d2316999"
    url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.2/gc-rust-v0.1.2-darwin-x86_64.tar.gz"
  else
    sha256 "4b003c3665de863929429cb5382f58a27e6de2e5589a5785775d3cb4afcd620c"
    url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.2/gc-rust-v0.1.2-darwin-arm64.tar.gz"
  end

  def install
    bin.install "gc-rust"
  end
end

class GcRust < Formula
  desc "Clone GitHub repositories like a champ!"
  homepage "https://github.com/patrickdappollonio/gc-rust"
  version "0.1.2"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "4b003c3665de863929429cb5382f58a27e6de2e5589a5785775d3cb4afcd620c"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.2/gc-rust-v0.1.2-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "aa9767fd4fc868af6fdad3ecbd8c493d73d189ad77bb7ac10a1a3e94d2316999"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.2/gc-rust-v0.1.2-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "93310557274c67e61805d34baa29ca0b3828dce39473c7d48d249f27f2cb9824"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.2/gc-rust-v0.1.2-linux-arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "b1d7153ca341c7f780251a6fb6f24ca9047eb16ac7aa7465672c5a062ca8b93f"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.2/gc-rust-v0.1.2-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "gc-rust"
  end
end

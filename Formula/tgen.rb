
class Tgen < Formula
  desc "A template tool with no dependencies that works like Helm templates or Consul templates."
  homepage "https://github.com/patrickdappollonio/tgen"
  version "2.0.3"
  on_macos do
    if Hardware::CPU.arm?
      sha256 "84f4a042e8e1a9bca3400a60efe6a0c3d581c3168b90a16597cc05b3d99421a8"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "f92580aa0ed27426ee30d04d244f9713dd120ffef3990b6d980659edd22d2b06"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_x86_64.tar.gz"
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      sha256 "c0f64a7744d99cf7d62bae809d3f478aee0e4c7f7ebd389df58fcd99d604a1e2"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_linux_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "8270ccef554191dd2867af32763aad1b24c919e28c65624e5cde74d1a00a9c3e"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "tgen"
  end
end

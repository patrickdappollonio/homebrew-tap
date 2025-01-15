class Tgen < Formula
  desc "A template tool with no dependencies that works like Helm templates or Consul templates."
  homepage "https://github.com/patrickdappollonio/tgen"
  version "2.0.3"

  if Hardware::CPU.intel?
    sha256 "f92580aa0ed27426ee30d04d244f9713dd120ffef3990b6d980659edd22d2b06"
    url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_x86_64.tar.gz"
  else
    sha256 "84f4a042e8e1a9bca3400a60efe6a0c3d581c3168b90a16597cc05b3d99421a8"
    url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_arm64.tar.gz"
  end

  def install
    bin.install "tgen"
  end
end

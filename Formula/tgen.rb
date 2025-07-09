class Tgen < Formula
  desc "A template tool with no dependencies that works like Helm templates or Consul templates."
  homepage "https://github.com/patrickdappollonio/tgen"
  version "2.0.3"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "84f4a042e8e1a9bca3400a60efe6a0c3d581c3168b90a16597cc05b3d99421a8"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "f92580aa0ed27426ee30d04d244f9713dd120ffef3990b6d980659edd22d2b06"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "8270ccef554191dd2867af32763aad1b24c919e28c65624e5cde74d1a00a9c3e"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "c0f64a7744d99cf7d62bae809d3f478aee0e4c7f7ebd389df58fcd99d604a1e2"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_linux_arm64.tar.gz"
    end
  end

  def install
    bin.install "tgen"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v2.0.3","repository":"patrickdappollonio/tgen","cached_at":"2025-07-09T00:25:07.984029403-04:00","assets":[{"id":148857718,"filename":"tgen_2.0.3_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_arm64.tar.gz","sha256":"84f4a042e8e1a9bca3400a60efe6a0c3d581c3168b90a16597cc05b3d99421a8"},{"id":148857715,"filename":"tgen_2.0.3_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_darwin_x86_64.tar.gz","sha256":"f92580aa0ed27426ee30d04d244f9713dd120ffef3990b6d980659edd22d2b06"},{"id":148857719,"filename":"tgen_2.0.3_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_linux_arm64.tar.gz","sha256":"c0f64a7744d99cf7d62bae809d3f478aee0e4c7f7ebd389df58fcd99d604a1e2"},{"id":148857721,"filename":"tgen_2.0.3_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.0.3/tgen_2.0.3_linux_x86_64.tar.gz","sha256":"8270ccef554191dd2867af32763aad1b24c919e28c65624e5cde74d1a00a9c3e"}]}

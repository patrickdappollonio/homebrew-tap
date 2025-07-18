class Tgen < Formula
  desc "A template tool with no dependencies that works like Helm templates or Consul templates."
  homepage "https://github.com/patrickdappollonio/tgen"
  version "2.1.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "03f88a2619fc374cc02874eb2531b20c1afdf12be798d975ae5f060b9f52ec65"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "af579f771b4aafbf32b2f55309153193c8979950250e592d2a54d691c7ed0486"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "1d675d880bec82df94247f17f4778b71fae6e27a38fc86a93a1383e35bbba36c"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "95a1d7a0ef4dee824cd6533143034729291b1411adc69539efb52407942d0034"
      url "https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_linux_arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v2.1.0","repository":"patrickdappollonio/tgen","cached_at":"2025-07-18T15:04:15.475720061-04:00","assets":[{"id":274178394,"filename":"tgen_2.1.0_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_darwin_arm64.tar.gz","sha256":"03f88a2619fc374cc02874eb2531b20c1afdf12be798d975ae5f060b9f52ec65"},{"id":274178402,"filename":"tgen_2.1.0_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_darwin_x86_64.tar.gz","sha256":"af579f771b4aafbf32b2f55309153193c8979950250e592d2a54d691c7ed0486"},{"id":274178397,"filename":"tgen_2.1.0_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_linux_arm64.tar.gz","sha256":"95a1d7a0ef4dee824cd6533143034729291b1411adc69539efb52407942d0034"},{"id":274178396,"filename":"tgen_2.1.0_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/tgen/releases/download/v2.1.0/tgen_2.1.0_linux_x86_64.tar.gz","sha256":"1d675d880bec82df94247f17f4778b71fae6e27a38fc86a93a1383e35bbba36c"}]}

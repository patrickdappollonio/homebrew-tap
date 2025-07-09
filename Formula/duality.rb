class Duality < Formula
  desc "Run multiple programs in parallel and wait for all to complete. A small command supervisor for your orchestration needs."
  homepage "https://github.com/patrickdappollonio/duality"
  version "1.0.0"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "37c4e0244bfd259929044ad880d7497dadc8cf3c304c94eed37b031d234effbc"
      url "https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "c0874d99371e2faa5f1446ab90fdb586699d18b2df5edb3a5e6373b520aee671"
      url "https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "fecf31acf7b59ae86402273bbaecfd8dd5f0b79609232c49a3390d7b63e8ebc7"
      url "https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "9dce7d61e4b67cf64d9501e5b2bb3359be38a10976afe120dd345c2f795517cf"
      url "https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "58bed5e79856ef32164000b608185f85e071685486e8d8337689efd8a1f21661"
      url "https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "duality"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/duality","cached_at":"2025-07-09T00:26:07.685321837-04:00","assets":[{"id":192578063,"filename":"duality_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_darwin_arm64.tar.gz","sha256":"37c4e0244bfd259929044ad880d7497dadc8cf3c304c94eed37b031d234effbc"},{"id":192578060,"filename":"duality_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_darwin_x86_64.tar.gz","sha256":"c0874d99371e2faa5f1446ab90fdb586699d18b2df5edb3a5e6373b520aee671"},{"id":192578056,"filename":"duality_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_linux_arm.tar.gz","sha256":"58bed5e79856ef32164000b608185f85e071685486e8d8337689efd8a1f21661"},{"id":192578057,"filename":"duality_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_linux_arm64.tar.gz","sha256":"9dce7d61e4b67cf64d9501e5b2bb3359be38a10976afe120dd345c2f795517cf"},{"id":192578061,"filename":"duality_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_linux_x86_64.tar.gz","sha256":"fecf31acf7b59ae86402273bbaecfd8dd5f0b79609232c49a3390d7b63e8ebc7"}]}

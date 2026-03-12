class WaitFor < Formula
  desc "A small, zero dependencies app that can be used as an init container to ping resources and check if they're available."
  homepage "https://github.com/patrickdappollonio/wait-for"
  version "1.2.2"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "93d68d2ecd013b57c31a6cae839edb2d8424846916104f96d8c60bcb9c302142"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "ea7803004da2f4395ae8291711b43af07f15b51cbb344d1a2bf2f9a8f9a730b7"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "39ef3332548cbc116384d993be7d8be789d0cb59e9a57c0bc590b5cb499767f8"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "75335d564d7b4ad8f29306d1b2f92a528ad6a5b062c3ea114eeab5149070d282"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "574d69f409579c08ccb25ebe83943f4c9179dae574ad2135f97f3779cfa544dc"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "wait-for"
  end
  test do
    system "#{bin}/wait-for --version"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.2.2","repository":"patrickdappollonio/wait-for","cached_at":"2026-03-12T02:22:33.570228501-04:00","assets":[{"id":372115014,"filename":"wait-for_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_darwin_arm64.tar.gz","sha256":"93d68d2ecd013b57c31a6cae839edb2d8424846916104f96d8c60bcb9c302142"},{"id":372115013,"filename":"wait-for_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_darwin_x86_64.tar.gz","sha256":"ea7803004da2f4395ae8291711b43af07f15b51cbb344d1a2bf2f9a8f9a730b7"},{"id":372115012,"filename":"wait-for_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_linux_arm.tar.gz","sha256":"574d69f409579c08ccb25ebe83943f4c9179dae574ad2135f97f3779cfa544dc"},{"id":372115001,"filename":"wait-for_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_linux_arm64.tar.gz","sha256":"75335d564d7b4ad8f29306d1b2f92a528ad6a5b062c3ea114eeab5149070d282"},{"id":372115000,"filename":"wait-for_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.2/wait-for_linux_x86_64.tar.gz","sha256":"39ef3332548cbc116384d993be7d8be789d0cb59e9a57c0bc590b5cb499767f8"}]}

class WaitFor < Formula
  desc "A small, zero dependencies app that can be used as an init container to ping resources and check if they're available."
  homepage "https://github.com/patrickdappollonio/wait-for"
  version "1.2.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "e9a50e98f625989df85a079e8a74cd450c5e65885b55161b529ff607bcdab9e3"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "a5df170cbc24677a51b5ab7fc492bc730e3ff41070b04b82bd23ab44835c7c6f"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "0d4bcea5e738e9c627f59ebd9de3750053211611b6b0df39d4f611654f604ccc"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "b2b49496749663912423e76a216d96a0dfe281006e45fab1b828510a2a51f072"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "81f2af850251bb1afad9a1fa4f675301ab2869ecdd1076d7a263c5506270e8bd"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_x86_64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.2.1","repository":"patrickdappollonio/wait-for","cached_at":"2025-07-09T00:25:13.046596475-04:00","assets":[{"id":219575872,"filename":"wait-for_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_darwin_arm64.tar.gz","sha256":"e9a50e98f625989df85a079e8a74cd450c5e65885b55161b529ff607bcdab9e3"},{"id":219575873,"filename":"wait-for_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_darwin_x86_64.tar.gz","sha256":"a5df170cbc24677a51b5ab7fc492bc730e3ff41070b04b82bd23ab44835c7c6f"},{"id":219575868,"filename":"wait-for_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_arm.tar.gz","sha256":"0d4bcea5e738e9c627f59ebd9de3750053211611b6b0df39d4f611654f604ccc"},{"id":219575866,"filename":"wait-for_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_arm64.tar.gz","sha256":"b2b49496749663912423e76a216d96a0dfe281006e45fab1b828510a2a51f072"},{"id":219575869,"filename":"wait-for_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_x86_64.tar.gz","sha256":"81f2af850251bb1afad9a1fa4f675301ab2869ecdd1076d7a263c5506270e8bd"}]}


class WaitFor < Formula
  desc "A small, zero dependencies app that can be used as an init container to ping resources and check if they're available."
  homepage "https://github.com/patrickdappollonio/wait-for"
  version "1.2.1"
  on_macos do
    if Hardware::CPU.arm?
      sha256 "e9a50e98f625989df85a079e8a74cd450c5e65885b55161b529ff607bcdab9e3"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_darwin_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "a5df170cbc24677a51b5ab7fc492bc730e3ff41070b04b82bd23ab44835c7c6f"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_darwin_x86_64.tar.gz"
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      sha256 "b2b49496749663912423e76a216d96a0dfe281006e45fab1b828510a2a51f072"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "81f2af850251bb1afad9a1fa4f675301ab2869ecdd1076d7a263c5506270e8bd"
      url "https://github.com/patrickdappollonio/wait-for/releases/download/v1.2.1/wait-for_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "wait-for"
  end
end

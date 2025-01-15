
class Tabloid < Formula
  desc "tabloid is a simple command line tool to parse and filter column-based CLI outputs from commands like kubectl or docker."
  homepage "https://github.com/patrickdappollonio/tabloid"
  version "0.0.3"
  on_macos do
    if Hardware::CPU.arm?
      sha256 "46bf5f0852fdb43adea1351361e9d145405d6522786fc905c0c7612a0e9a4414"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "c41ae387ecc4b0f070bd51afdb31ae52eff96074c40fc2d526d6c5a47fbc7027"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_x86_64.tar.gz"
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      sha256 "10bf19beace0b4746fc036b9b9fefb47c1d002cb858ac1c9fc6ffcede42e068a"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "64843392278672cb3cb02d1f22496b10290cf9f7ff65f7cd48a5684ae2755963"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "tabloid"
  end
end

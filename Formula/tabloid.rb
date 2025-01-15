class Tabloid < Formula
  desc "tabloid is a simple command line tool to parse and filter column-based CLI outputs from commands like kubectl or docker."
  homepage "https://github.com/patrickdappollonio/tabloid"
  version "0.0.3"

  if Hardware::CPU.intel?
    sha256 "c41ae387ecc4b0f070bd51afdb31ae52eff96074c40fc2d526d6c5a47fbc7027"
    url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_x86_64.tar.gz"
  else
    sha256 "46bf5f0852fdb43adea1351361e9d145405d6522786fc905c0c7612a0e9a4414"
    url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_arm64.tar.gz"
  end

  def install
    bin.install "tabloid"
  end
end

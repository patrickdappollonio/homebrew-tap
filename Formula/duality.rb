class Duality < Formula
  desc "Run multiple programs in parallel and wait for all to complete. A small command supervisor for your orchestration needs."
  homepage "https://github.com/patrickdappollonio/duality"
  version "1.0.0"

  if Hardware::CPU.intel?
    sha256 "c0874d99371e2faa5f1446ab90fdb586699d18b2df5edb3a5e6373b520aee671"
    url "https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_darwin_x86_64.tar.gz"
  else
    sha256 "37c4e0244bfd259929044ad880d7497dadc8cf3c304c94eed37b031d234effbc"
    url "https://github.com/patrickdappollonio/duality/releases/download/v1.0.0/duality_darwin_arm64.tar.gz"
  end

  def install
    bin.install "duality"
  end
end

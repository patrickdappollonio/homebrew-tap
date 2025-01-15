class FindProject < Formula
  desc "Traverse through folders with ease!"
  homepage "https://github.com/patrickdappollonio/find-project"
  version "1.0.0"

  if Hardware::CPU.intel?
    sha256 "1a5550b4fe44d1d3cbc6e3f3ac5cd853f731f69062bd1f7934d9257941365805"
    url "https://github.com/patrickdappollonio/find-project/releases/download/v1.0.0/find-project-v1.0.0-darwin-x86_64.tar.gz"
  else
    sha256 "3284cf24101ac34c717a590d1230555091603c26183fcd0765d57b7fd2539d16"
    url "https://github.com/patrickdappollonio/find-project/releases/download/v1.0.0/find-project-v1.0.0-darwin-arm64.tar.gz"
  end

  def install
    bin.install "find-project"
  end
end

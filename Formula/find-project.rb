class FindProject < Formula
  desc "Traverse through folders with ease!"
  homepage "https://github.com/patrickdappollonio/find-project"
  version "1.0.0"
  on_macos do
    if Hardware::CPU.arm?
      sha256 "3284cf24101ac34c717a590d1230555091603c26183fcd0765d57b7fd2539d16"
      url "https://github.com/patrickdappollonio/find-project/releases/download/v1.0.0/find-project-v1.0.0-darwin-arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "1a5550b4fe44d1d3cbc6e3f3ac5cd853f731f69062bd1f7934d9257941365805"
      url "https://github.com/patrickdappollonio/find-project/releases/download/v1.0.0/find-project-v1.0.0-darwin-x86_64.tar.gz"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "4252233167235660b33e1476eef073c625e0a5268ddecb7e3853a671d79518f6"
      url "https://github.com/patrickdappollonio/find-project/releases/download/v1.0.0/find-project-v1.0.0-linux-arm64.tar.gz"
    end
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "f2b029487933af98f29988f16b9cbf608b0968f48bc299f69694145a6bf57271"
      url "https://github.com/patrickdappollonio/find-project/releases/download/v1.0.0/find-project-v1.0.0-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "find-project"
  end
end

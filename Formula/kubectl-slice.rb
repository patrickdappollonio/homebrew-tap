class KubectlSlice < Formula
  desc "Split multiple Kubernetes files into smaller files with ease. Split multi-YAML files into individual files."
  homepage "https://github.com/patrickdappollonio/kubectl-slice"
  version "1.4.1"
  on_macos do
    if Hardware::CPU.arm?
      sha256 "0adbed2200c3020fe7a751871b1469e21ce749c3d65e163d3deb2125562fbba2"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.1/kubectl-slice_darwin_arm64.tar.gz"
    end
    if Hardware::CPU.intel?
      sha256 "78790007b8deb5c0c27cb28b6283af7560f0df48b806fedb720eb01862122e8c"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.1/kubectl-slice_darwin_x86_64.tar.gz"
    end
  end
  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "a67bd8a292b7de9b7a55fb5a345df01d7c2a2283a1cb77e808f19b7f5434f1f7"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.1/kubectl-slice_linux_arm64.tar.gz"
    end
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "01d3ceae02fae67e93251c64ee53e335665ead65ee923aea650bc33a0c15b64f"
      url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.1/kubectl-slice_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "kubectl-slice"
  end
  test do
    system "#{bin}/kubectl-slice -v"
  end
end

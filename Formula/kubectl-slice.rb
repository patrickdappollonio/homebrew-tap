class KubectlSlice < Formula
  desc "Split multiple Kubernetes files into smaller files with ease. Split multi-YAML files into individual files."
  homepage "https://github.com/patrickdappollonio/kubectl-slice"
  version "1.4.1"

  if Hardware::CPU.intel?
    sha256 "78790007b8deb5c0c27cb28b6283af7560f0df48b806fedb720eb01862122e8c"
    url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.1/kubectl-slice_darwin_x86_64.tar.gz"
  else
    sha256 "0adbed2200c3020fe7a751871b1469e21ce749c3d65e163d3deb2125562fbba2"
    url "https://github.com/patrickdappollonio/kubectl-slice/releases/download/v1.4.1/kubectl-slice_darwin_arm64.tar.gz"
  end

  def install
    bin.install "kubectl-slice"
  end
end

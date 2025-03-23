class HelmListCharts < Formula
  desc "Navigate Helm chart indexes without adding them to your machine and with ease."
  homepage "https://github.com/patrickdappollonio/helm-list-charts"
  version "1.0.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "f5a87ca56984f38c0dd34c07b5ba404f10f24bf256d676f48524ae461eb71d2f"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.0/helm-list-charts-v1.0.0-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "671fcec122a9e5b95dad023a05df77a0c0c38d0dfd239917dba10cfc74be72a0"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.0/helm-list-charts-v1.0.0-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "8b8e31eecf1c7b895526b21ca2ccb70a40e3160e4455d802a9b10957af8d6306"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.0/helm-list-charts-v1.0.0-linux-arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "1cc43839fe3a89cea7d737d32d7d2f259add313cb5fc8a8aef054cc2c72e0970"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.0/helm-list-charts-v1.0.0-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "helm-list-charts"
  end
end

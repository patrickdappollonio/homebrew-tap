class HelmListCharts < Formula
  desc "Navigate Helm chart indexes without adding them to your machine and with ease."
  homepage "https://github.com/patrickdappollonio/helm-list-charts"
  version "1.0.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "0c5f2bbd346b89dd416eaaa616853e7f485cdcf284cab1aa99f075ae79e3fee7"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "70495e3b0ff663ca7db2edec6ee3536ae587e42d3d3e74c0376ee4dfd28c1885"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "cc4e4df0da0b851ea318daaa9a8676e0e8ee8bffb51a5259ee9514fd78fa0799"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-linux-arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "dc9ec5ad1d419be37d83211e2815322678ec3b39a9605367df387503b4086ae2"
      url "https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "helm-list-charts"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.1","repository":"patrickdappollonio/helm-list-charts","cached_at":"2025-07-09T00:25:26.091733086-04:00","assets":[{"id":239982026,"filename":"helm-list-charts-v1.0.1-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-darwin-arm64.tar.gz","sha256":"0c5f2bbd346b89dd416eaaa616853e7f485cdcf284cab1aa99f075ae79e3fee7"},{"id":239982030,"filename":"helm-list-charts-v1.0.1-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-darwin-x86_64.tar.gz","sha256":"70495e3b0ff663ca7db2edec6ee3536ae587e42d3d3e74c0376ee4dfd28c1885"},{"id":239982082,"filename":"helm-list-charts-v1.0.1-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-linux-arm64.tar.gz","sha256":"cc4e4df0da0b851ea318daaa9a8676e0e8ee8bffb51a5259ee9514fd78fa0799"},{"id":239982029,"filename":"helm-list-charts-v1.0.1-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/helm-list-charts/releases/download/v1.0.1/helm-list-charts-v1.0.1-linux-x86_64.tar.gz","sha256":"dc9ec5ad1d419be37d83211e2815322678ec3b39a9605367df387503b4086ae2"}]}

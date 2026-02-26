class Undrained < Formula
  desc "A CLI tool that audits Kubernetes PodDisruptionBudgets and flags configurations that block pod evictions during voluntary disruptions like node drains, cluster upgrades, and scaling operations."
  homepage "https://github.com/patrickdappollonio/undrained"
  version "1.0.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "35575002101d4b5dc6a5729636326f5292fbc3ab25a4d3082cf5d1baf78467a1"
      url "https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "07ef42e63ea9e731cc2bf8c3f96d31cf78f7f045cfcacf3902559ed0bb775ce7"
      url "https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "9dda4568e05f4967663e85b6b0a520b96ee34221f580b21144a3a47f4467536d"
      url "https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "b35bd7be0dba7ec41c317df03e7f0eddb1e1b23621eef59f3be6ef0a9661e49a"
      url "https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_linux_arm64.tar.gz"
    end
  end

  def install
    bin.install "undrained"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/undrained","cached_at":"2026-02-25T23:38:27.669330534-05:00","assets":[{"id":362586785,"filename":"undrained_1.0.0_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_darwin_arm64.tar.gz","sha256":"35575002101d4b5dc6a5729636326f5292fbc3ab25a4d3082cf5d1baf78467a1"},{"id":362586788,"filename":"undrained_1.0.0_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_darwin_x86_64.tar.gz","sha256":"07ef42e63ea9e731cc2bf8c3f96d31cf78f7f045cfcacf3902559ed0bb775ce7"},{"id":362586787,"filename":"undrained_1.0.0_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_linux_arm64.tar.gz","sha256":"b35bd7be0dba7ec41c317df03e7f0eddb1e1b23621eef59f3be6ef0a9661e49a"},{"id":362586798,"filename":"undrained_1.0.0_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/undrained/releases/download/v1.0.0/undrained_1.0.0_linux_x86_64.tar.gz","sha256":"9dda4568e05f4967663e85b6b0a520b96ee34221f580b21144a3a47f4467536d"}]}

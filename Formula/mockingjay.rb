class Mockingjay < Formula
  desc "A YAML-configurable HTTP server that uses Go templates to create dynamic mock APIs with regex routing, middleware support, and 100+ helper functions."
  homepage "https://github.com/patrickdappollonio/mockingjay"
  version "1.0.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "977a8b641dd3d8dc57e51cb099f7301000f48a91fcf4cf3c6d62fa51a90754b5"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "ab321f646c99d5b4fb4a4c2ef3164c542d0ce1917b3cae09ec67b6c04f800330"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "477ed723920a439a194fc4385a41a1098e456e2bd0172cc17228b816699e3707"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_linux_x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "4c09586700b51955acadaf84b558a6ef9aea008e6930dbe71edbf6338185e142"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_linux_arm64.tar.gz"
    end
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "505d3e1b3eee120b904105cca28792597f2c16cbd46f934dc5bd79ea154e64f8"
      url "https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_linux_arm.tar.gz"
    end
  end

  def install
    bin.install "mockingjay"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.1","repository":"patrickdappollonio/mockingjay","cached_at":"2026-10-02T20:11:15.642653765-04:00","assets":[{"id":606533784,"filename":"mockingjay_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_darwin_arm64.tar.gz","sha256":"977a8b641dd3d8dc57e51cb099f7301000f48a91fcf4cf3c6d62fa51a90754b5"},{"id":606533785,"filename":"mockingjay_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_darwin_x86_64.tar.gz","sha256":"ab321f646c99d5b4fb4a4c2ef3164c542d0ce1917b3cae09ec67b6c04f800330"},{"id":606533813,"filename":"mockingjay_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_linux_arm.tar.gz","sha256":"505d3e1b3eee120b904105cca28792597f2c16cbd46f934dc5bd79ea154e64f8"},{"id":606533814,"filename":"mockingjay_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_linux_arm64.tar.gz","sha256":"4c09586700b51955acadaf84b558a6ef9aea008e6930dbe71edbf6338185e142"},{"id":606533780,"filename":"mockingjay_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/mockingjay/releases/download/v1.0.1/mockingjay_linux_x86_64.tar.gz","sha256":"477ed723920a439a194fc4385a41a1098e456e2bd0172cc17228b816699e3707"}]}

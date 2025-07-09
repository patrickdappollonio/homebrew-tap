class ReverseProxyHost < Formula
  desc "Reverse a connection from a local service with a custom Host header onto a new port."
  homepage "https://github.com/patrickdappollonio/reverse-proxy-host"
  version "1.0.0"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "dc0fd3db02a49a07a6f4e123e4c994f92159c1c0dfba694310f6b4036559175f"
      url "https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "f97ff738171dc3743bfeabca279ebbb5d99874850c8deec75c5b5aff18b22e41"
      url "https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "7485f6488b5b9c0f5b80d00aa0eaccaac9cc69d0120372925b7c197103d3230f"
      url "https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "58c20ccca3e218cdc9a751e64913a917b45f8fa634402f55ebdc1c0b690b336b"
      url "https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "00a2cdcb486fe7ba0656e05d8a16e83cb9daf2b53ae4afd2215c11f45173aef5"
      url "https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "reverse-proxy-host"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"patrickdappollonio/reverse-proxy-host","cached_at":"2025-07-09T00:26:09.043969754-04:00","assets":[{"id":233838978,"filename":"reverse-proxy-host_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_darwin_arm64.tar.gz","sha256":"dc0fd3db02a49a07a6f4e123e4c994f92159c1c0dfba694310f6b4036559175f"},{"id":233838975,"filename":"reverse-proxy-host_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_darwin_x86_64.tar.gz","sha256":"f97ff738171dc3743bfeabca279ebbb5d99874850c8deec75c5b5aff18b22e41"},{"id":233838977,"filename":"reverse-proxy-host_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_linux_arm.tar.gz","sha256":"7485f6488b5b9c0f5b80d00aa0eaccaac9cc69d0120372925b7c197103d3230f"},{"id":233838972,"filename":"reverse-proxy-host_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_linux_arm64.tar.gz","sha256":"58c20ccca3e218cdc9a751e64913a917b45f8fa634402f55ebdc1c0b690b336b"},{"id":233838970,"filename":"reverse-proxy-host_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/reverse-proxy-host/releases/download/v1.0.0/reverse-proxy-host_linux_x86_64.tar.gz","sha256":"00a2cdcb486fe7ba0656e05d8a16e83cb9daf2b53ae4afd2215c11f45173aef5"}]}

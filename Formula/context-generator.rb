class ContextGenerator < Formula
  desc "A fast, efficient command-line tool written in Rust that generates copy-pastable context from your source code, perfect for providing to AI assistants like ChatGPT, Claude, or Copilot."
  homepage "https://github.com/patrickdappollonio/context-generator"
  version "1.0.1"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "b431a276dd5a9773761274c6a6623f62fad675e6b017c35103e86453aa939c76"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "1d01e9fe2207cf62f3414af9cf5d646dac9eb882235bff5645081ce62bef662f"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "2452870af805cfddd54449b6f50f8c5659e9af5b2026ad153927de80ec71cddd"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-linux-x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "3f56e91faa3f3b68fd21133ae99f628eebecfd6ede6934b67224fee4655df1ba"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-linux-arm64.tar.gz"
    end
  end

  def install
    bin.install "context-generator"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v1.0.1","repository":"patrickdappollonio/context-generator","cached_at":"2025-07-25T00:17:11.305858395-04:00","assets":[{"id":276181313,"filename":"context-generator-v1.0.1-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-darwin-arm64.tar.gz","sha256":"b431a276dd5a9773761274c6a6623f62fad675e6b017c35103e86453aa939c76"},{"id":276181300,"filename":"context-generator-v1.0.1-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-darwin-x86_64.tar.gz","sha256":"1d01e9fe2207cf62f3414af9cf5d646dac9eb882235bff5645081ce62bef662f"},{"id":276181503,"filename":"context-generator-v1.0.1-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-linux-arm64.tar.gz","sha256":"3f56e91faa3f3b68fd21133ae99f628eebecfd6ede6934b67224fee4655df1ba"},{"id":276181523,"filename":"context-generator-v1.0.1-linux-x86_64-musl.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-linux-x86_64-musl.tar.gz","sha256":"db4c66fb0be5c482e910fadde4c664cc58ede19991e63cbf1005ce29bd1f880f"},{"id":276181258,"filename":"context-generator-v1.0.1-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.1/context-generator-v1.0.1-linux-x86_64.tar.gz","sha256":"2452870af805cfddd54449b6f50f8c5659e9af5b2026ad153927de80ec71cddd"}]}

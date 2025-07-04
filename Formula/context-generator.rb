class ContextGenerator < Formula
  desc "A fast, efficient command-line tool written in Rust that generates copy-pastable context from your source code, perfect for providing to AI assistants like ChatGPT, Claude, or Copilot."
  homepage "https://github.com/patrickdappollonio/context-generator"
  version "1.0.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "5efd686785ac51133b90011189460f04fd325c9046596f5e4500e67454da13d6"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.0/context-generator-v1.0.0-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "63694e77c3adada38ec1d6b7d15ee6115ea73277610939ae4fb4595c064dc82e"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.0/context-generator-v1.0.0-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "95dc1986cc74ac2197160d19f9f59fd4864b14c70a675d6681f28787929e425f"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.0/context-generator-v1.0.0-linux-arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "146815a038ac78148103eb9ed83dd5fe9ea7f8be4ed313425c8728092a972db6"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.0/context-generator-v1.0.0-linux-x86_64-musl.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "9ffaa676613c5b2166db72b8ead5a306ed5a79782031bb63ae19b2d97da0cfb8"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.0.0/context-generator-v1.0.0-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "context-generator"
  end
end

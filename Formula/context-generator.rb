class ContextGenerator < Formula
  desc "A fast, efficient command-line tool written in Rust that generates copy-pastable context from your source code, perfect for providing to AI assistants like ChatGPT, Claude, or Copilot."
  homepage "https://github.com/patrickdappollonio/context-generator"
  version "1.2.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "7bbbdc255e4c5cb9917904058e527110b45d10592b7322088a6c4e82e5adc5b2"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "a6184f8e510ceed4b58285830cbe89ee716756d8af1caeffe26dfbb6784c2be4"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "562cb3739be41ac528bc6e340a699728d103c488e5066ca5afb6773421196915"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-linux-x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "e6bd00d4c30a7459d5c28c436877884fa4c45b2505240faad5a1ac63d815cd71"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.2.0","repository":"patrickdappollonio/context-generator","cached_at":"2025-10-21T21:31:57.493768933-04:00","assets":[{"id":307106560,"filename":"context-generator-v1.2.0-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-darwin-arm64.tar.gz","sha256":"7bbbdc255e4c5cb9917904058e527110b45d10592b7322088a6c4e82e5adc5b2"},{"id":307106582,"filename":"context-generator-v1.2.0-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-darwin-x86_64.tar.gz","sha256":"a6184f8e510ceed4b58285830cbe89ee716756d8af1caeffe26dfbb6784c2be4"},{"id":307106769,"filename":"context-generator-v1.2.0-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-linux-arm64.tar.gz","sha256":"e6bd00d4c30a7459d5c28c436877884fa4c45b2505240faad5a1ac63d815cd71"},{"id":307106770,"filename":"context-generator-v1.2.0-linux-x86_64-musl.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-linux-x86_64-musl.tar.gz","sha256":"c8b0da24a2d0cada0247a65b2baa47c233c5ca999b5e6f82e3bbe12f2869bdc4"},{"id":307106531,"filename":"context-generator-v1.2.0-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.2.0/context-generator-v1.2.0-linux-x86_64.tar.gz","sha256":"562cb3739be41ac528bc6e340a699728d103c488e5066ca5afb6773421196915"}]}

class ContextGenerator < Formula
  desc "A fast, efficient command-line tool written in Rust that generates copy-pastable context from your source code, perfect for providing to AI assistants like ChatGPT, Claude, or Copilot."
  homepage "https://github.com/patrickdappollonio/context-generator"
  version "1.1.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "7834197d608cd88ff7bcae18f71929c5a439e627cff2b2c74e8a5e5d45a70544"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "229968a53e58f5c4d58c8d3ace2e0fba19d74055dbbdf2154a02d55c94a6eff1"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "77745f64ff2a4882bafea986b1324a5d4cd9bf6775442bb53329b06c72a14a45"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-linux-x86_64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "ef8080d72a428f02de7e617f188a3068343da4d09e78efd59f7ee2312694e5d3"
      url "https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v1.1.0","repository":"patrickdappollonio/context-generator","cached_at":"2025-08-16T20:18:28.526983098-04:00","assets":[{"id":283222722,"filename":"context-generator-v1.1.0-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-darwin-arm64.tar.gz","sha256":"7834197d608cd88ff7bcae18f71929c5a439e627cff2b2c74e8a5e5d45a70544"},{"id":283222889,"filename":"context-generator-v1.1.0-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-darwin-x86_64.tar.gz","sha256":"229968a53e58f5c4d58c8d3ace2e0fba19d74055dbbdf2154a02d55c94a6eff1"},{"id":283223518,"filename":"context-generator-v1.1.0-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-linux-arm64.tar.gz","sha256":"ef8080d72a428f02de7e617f188a3068343da4d09e78efd59f7ee2312694e5d3"},{"id":283223548,"filename":"context-generator-v1.1.0-linux-x86_64-musl.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-linux-x86_64-musl.tar.gz","sha256":"ccb3223beaf9f5a247088dde165d19d0b2d7f55c16da5e35fa06532efcc3f331"},{"id":283222758,"filename":"context-generator-v1.1.0-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/context-generator/releases/download/v1.1.0/context-generator-v1.1.0-linux-x86_64.tar.gz","sha256":"77745f64ff2a4882bafea986b1324a5d4cd9bf6775442bb53329b06c72a14a45"}]}

class Dux < Formula
  desc "Dux is a terminal UI that lets you run multiple AI coding agents side by side, each in its own git worktree, with full companion terminals, macros, commit generation, and a command palette that knows more tricks than you do."
  homepage "https://github.com/patrickdappollonio/dux"
  version "0.1.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "bdbb03d5c09e32de55e472f5b5c6ae22ed4e4da91df55fde3b54a6cc1463a0cb"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "b327a61112b756a428192bcf53ca4628361869ae81b49e86cda3242feb89098a"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-darwin-amd64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "6148cbfa6dade5a398d764fb53830e53129092702507bec8164f7897d9b6546a"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-linux-amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "5b887f45d1d4141df1f689c7c291daf55aaf1fce0a71737c12893ef3c6c1842d"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-linux-arm64.tar.gz"
    end
  end

  def install
    bin.install "dux"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v0.1.0","repository":"patrickdappollonio/dux","cached_at":"2026-04-11T01:09:06.923764015-04:00","assets":[{"id":393860652,"filename":"dux-darwin-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-darwin-amd64.tar.gz","sha256":"b327a61112b756a428192bcf53ca4628361869ae81b49e86cda3242feb89098a"},{"id":393860460,"filename":"dux-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-darwin-arm64.tar.gz","sha256":"bdbb03d5c09e32de55e472f5b5c6ae22ed4e4da91df55fde3b54a6cc1463a0cb"},{"id":393860665,"filename":"dux-linux-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-linux-amd64.tar.gz","sha256":"6148cbfa6dade5a398d764fb53830e53129092702507bec8164f7897d9b6546a"},{"id":393860769,"filename":"dux-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.1.0/dux-linux-arm64.tar.gz","sha256":"5b887f45d1d4141df1f689c7c291daf55aaf1fce0a71737c12893ef3c6c1842d"}]}

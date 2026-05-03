class Dux < Formula
  desc "Dux is a terminal UI that lets you run multiple AI coding agents side by side, each in its own git worktree, with full companion terminals, macros, commit generation, and a command palette that knows more tricks than you do."
  homepage "https://github.com/patrickdappollonio/dux"
  version "0.4.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "52d57686de7624351013e64adb2ba77c828c89567b5b1a1601b324be5d847104"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "19f4da163037a827edcecfc6bd0171caa5373feed8f4984e6f29cebb32c32c25"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-darwin-amd64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "a1c449989e9c4dd53b260d75d29d0d5d6832b3852cf5327f3725b5e7bb881102"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-linux-amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "3db2c0dc70f674bf5f2cec80faaa098172dfb10a7e6b30d237a2a6c11f94335a"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v0.4.0","repository":"patrickdappollonio/dux","cached_at":"2026-05-03T01:11:54.533807711-04:00","assets":[{"id":410909741,"filename":"dux-darwin-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-darwin-amd64.tar.gz","sha256":"19f4da163037a827edcecfc6bd0171caa5373feed8f4984e6f29cebb32c32c25"},{"id":410910155,"filename":"dux-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-darwin-arm64.tar.gz","sha256":"52d57686de7624351013e64adb2ba77c828c89567b5b1a1601b324be5d847104"},{"id":410909604,"filename":"dux-linux-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-linux-amd64.tar.gz","sha256":"a1c449989e9c4dd53b260d75d29d0d5d6832b3852cf5327f3725b5e7bb881102"},{"id":410909468,"filename":"dux-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.4.0/dux-linux-arm64.tar.gz","sha256":"3db2c0dc70f674bf5f2cec80faaa098172dfb10a7e6b30d237a2a6c11f94335a"}]}

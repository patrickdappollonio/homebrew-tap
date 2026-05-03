class Dux < Formula
  desc "Dux is a terminal UI that lets you run multiple AI coding agents side by side, each in its own git worktree, with full companion terminals, macros, commit generation, and a command palette that knows more tricks than you do."
  homepage "https://github.com/patrickdappollonio/dux"
  version "0.3.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "0f0ca99797adb169b0ba1cca18c068e12bd4bdc42656dd0b52ca097cf46eb855"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "c4a25572ae365a7d91ae43ccaf2465c971f5c87b1239dd03c05f9159a2c78301"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-darwin-amd64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "679e2d50dfcfb0c341bb4cafce44a3fefc7c09b35b1ff77ddc120b58178cdaaa"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-linux-amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "1b9a5b6fc610f1b08c0ee8bea76882f711244f5711e84ffcb77f4828eb9af050"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v0.3.0","repository":"patrickdappollonio/dux","cached_at":"2026-05-02T23:11:32.687035814-04:00","assets":[{"id":410879102,"filename":"dux-darwin-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-darwin-amd64.tar.gz","sha256":"c4a25572ae365a7d91ae43ccaf2465c971f5c87b1239dd03c05f9159a2c78301"},{"id":410878995,"filename":"dux-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-darwin-arm64.tar.gz","sha256":"0f0ca99797adb169b0ba1cca18c068e12bd4bdc42656dd0b52ca097cf46eb855"},{"id":410879362,"filename":"dux-linux-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-linux-amd64.tar.gz","sha256":"679e2d50dfcfb0c341bb4cafce44a3fefc7c09b35b1ff77ddc120b58178cdaaa"},{"id":410879288,"filename":"dux-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.3.0/dux-linux-arm64.tar.gz","sha256":"1b9a5b6fc610f1b08c0ee8bea76882f711244f5711e84ffcb77f4828eb9af050"}]}

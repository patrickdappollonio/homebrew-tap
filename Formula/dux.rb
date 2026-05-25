class Dux < Formula
  desc "Dux is a terminal UI that lets you run multiple AI coding agents side by side, each in its own git worktree, with full companion terminals, macros, commit generation, and a command palette that knows more tricks than you do."
  homepage "https://github.com/patrickdappollonio/dux"
  version "0.6.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "b303482c691e8b85cf836a5ea9d69b26132ca826ab6581477f6dd2b5992de5db"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "8176eacb9613f1d48921675674573e62dba73f1a20d06db906f9b79bc1b4b2f6"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-darwin-amd64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "827b820f9060198eb6be22123b17d6309c87ee3ba1af633823016394140d5a98"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-linux-amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "e66c0c5635429b671c143f836268ecc165a5b6b93d5d48feaf15ec68394aba97"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v0.6.0","repository":"patrickdappollonio/dux","cached_at":"2026-05-24T20:56:23.151304991-04:00","assets":[{"id":428908331,"filename":"dux-darwin-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-darwin-amd64.tar.gz","sha256":"8176eacb9613f1d48921675674573e62dba73f1a20d06db906f9b79bc1b4b2f6"},{"id":428907953,"filename":"dux-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-darwin-arm64.tar.gz","sha256":"b303482c691e8b85cf836a5ea9d69b26132ca826ab6581477f6dd2b5992de5db"},{"id":428908249,"filename":"dux-linux-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-linux-amd64.tar.gz","sha256":"827b820f9060198eb6be22123b17d6309c87ee3ba1af633823016394140d5a98"},{"id":428908254,"filename":"dux-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.6.0/dux-linux-arm64.tar.gz","sha256":"e66c0c5635429b671c143f836268ecc165a5b6b93d5d48feaf15ec68394aba97"}]}

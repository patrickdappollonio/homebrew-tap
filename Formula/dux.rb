class Dux < Formula
  desc "Dux is a terminal UI that lets you run multiple AI coding agents side by side, each in its own git worktree, with full companion terminals, macros, commit generation, and a command palette that knows more tricks than you do."
  homepage "https://github.com/patrickdappollonio/dux"
  version "0.2.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "0f0518e68cacb91fb2233813e7ec1fbfb2d1271206a75be0189f2484ac96ed80"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "97d53509ee6f9ba21ab57bb533f8962af693a6b0501da23945693f9cb43e1a41"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-darwin-amd64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "0a942cd97a7a15e936b8db505eef7f6a123d233fb8ea51d89882b56aaabf5569"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-linux-amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "00243a1466e91c4f63d00e9236bec7eff1b581b8798944df895ae5006e5baa5a"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v0.2.0","repository":"patrickdappollonio/dux","cached_at":"2026-04-22T01:01:28.612910861-04:00","assets":[{"id":402131913,"filename":"dux-darwin-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-darwin-amd64.tar.gz","sha256":"97d53509ee6f9ba21ab57bb533f8962af693a6b0501da23945693f9cb43e1a41"},{"id":402131934,"filename":"dux-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-darwin-arm64.tar.gz","sha256":"0f0518e68cacb91fb2233813e7ec1fbfb2d1271206a75be0189f2484ac96ed80"},{"id":402132492,"filename":"dux-linux-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-linux-amd64.tar.gz","sha256":"0a942cd97a7a15e936b8db505eef7f6a123d233fb8ea51d89882b56aaabf5569"},{"id":402132136,"filename":"dux-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.2.0/dux-linux-arm64.tar.gz","sha256":"00243a1466e91c4f63d00e9236bec7eff1b581b8798944df895ae5006e5baa5a"}]}

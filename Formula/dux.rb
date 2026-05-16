class Dux < Formula
  desc "Dux is a terminal UI that lets you run multiple AI coding agents side by side, each in its own git worktree, with full companion terminals, macros, commit generation, and a command palette that knows more tricks than you do."
  homepage "https://github.com/patrickdappollonio/dux"
  version "0.5.0"
  license "MIT"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "f3af05529db8ea133c60f7b1a6dd5b35bb19f9656488130ab9ed55ae47ff15a0"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "1cfc5aba3a9c7bcc02d77540d889faeff14bfa542e50c1e4d848f555a128e407"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-darwin-amd64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "7b9aa0af33b5338d665796c23956fb852b8bc4aa897399cf00c9d543f0d3e3d6"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-linux-amd64.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "e66d25aa6d2f583bc9a9327ee54e4e2e5f8f876f981b80b0500e389ec0dcb1ea"
      url "https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-linux-arm64.tar.gz"
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
# TAPGEN_CACHE: {"tag":"v0.5.0","repository":"patrickdappollonio/dux","cached_at":"2026-05-15T23:11:08.036856529-04:00","assets":[{"id":421486567,"filename":"dux-darwin-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-darwin-amd64.tar.gz","sha256":"1cfc5aba3a9c7bcc02d77540d889faeff14bfa542e50c1e4d848f555a128e407"},{"id":421486811,"filename":"dux-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-darwin-arm64.tar.gz","sha256":"f3af05529db8ea133c60f7b1a6dd5b35bb19f9656488130ab9ed55ae47ff15a0"},{"id":421486894,"filename":"dux-linux-amd64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-linux-amd64.tar.gz","sha256":"7b9aa0af33b5338d665796c23956fb852b8bc4aa897399cf00c9d543f0d3e3d6"},{"id":421486434,"filename":"dux-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/dux/releases/download/v0.5.0/dux-linux-arm64.tar.gz","sha256":"e66d25aa6d2f583bc9a9327ee54e4e2e5f8f876f981b80b0500e389ec0dcb1ea"}]}

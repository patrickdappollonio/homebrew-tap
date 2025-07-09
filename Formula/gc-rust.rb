class GcRust < Formula
  desc "Clone GitHub repositories like a champ!"
  homepage "https://github.com/patrickdappollonio/gc-rust"
  version "0.1.3"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "d20ed9ff75409112f436807f19281e7186877ce5752a09a17a436783a91155f0"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-darwin-arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "ac0a6cafae32f183d2cca05d760e006da26438f8beabff5b25ddd7c9afd2c818"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-darwin-x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "1273dba65c5dea4bbdfca4413ffccdcc64967fca68658cb4f9d57ad5fe7a3112"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-linux-arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "aabd0cfcf215dfc47f6b6ffe66a1f0c6e55bf93e699c0be755e6a723128ea7e3"
      url "https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-linux-x86_64.tar.gz"
    end
  end

  def install
    bin.install "gc-rust"
  end
  def caveats
    <<~EOS
      If you want to use "gc-rust" simply as "gc", ensure you create a function or alias for it.
      See https://github.com/patrickdappollonio/gc-rust#usage for instructions on how to do so.
    EOS
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v0.1.3","repository":"patrickdappollonio/gc-rust","cached_at":"2025-07-09T00:26:06.268818079-04:00","assets":[{"id":266994675,"filename":"gc-rust-v0.1.3-darwin-arm64.tar.gz","url":"https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-darwin-arm64.tar.gz","sha256":"d20ed9ff75409112f436807f19281e7186877ce5752a09a17a436783a91155f0"},{"id":266994646,"filename":"gc-rust-v0.1.3-darwin-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-darwin-x86_64.tar.gz","sha256":"ac0a6cafae32f183d2cca05d760e006da26438f8beabff5b25ddd7c9afd2c818"},{"id":266994938,"filename":"gc-rust-v0.1.3-linux-arm64.tar.gz","url":"https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-linux-arm64.tar.gz","sha256":"1273dba65c5dea4bbdfca4413ffccdcc64967fca68658cb4f9d57ad5fe7a3112"},{"id":266994676,"filename":"gc-rust-v0.1.3-linux-x86_64.tar.gz","url":"https://github.com/patrickdappollonio/gc-rust/releases/download/v0.1.3/gc-rust-v0.1.3-linux-x86_64.tar.gz","sha256":"aabd0cfcf215dfc47f6b6ffe66a1f0c6e55bf93e699c0be755e6a723128ea7e3"}]}

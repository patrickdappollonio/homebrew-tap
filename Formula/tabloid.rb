class Tabloid < Formula
  desc "tabloid is a simple command line tool to parse and filter column-based CLI outputs from commands like kubectl or docker."
  homepage "https://github.com/patrickdappollonio/tabloid"
  version "0.0.3"
  #
  # MacOS builds
  #
  on_macos do
    # MacOS ARM64 builds
    if Hardware::CPU.arm?
      sha256 "46bf5f0852fdb43adea1351361e9d145405d6522786fc905c0c7612a0e9a4414"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_arm64.tar.gz"
    end
    # MacOS Intel builds
    if Hardware::CPU.intel?
      sha256 "c41ae387ecc4b0f070bd51afdb31ae52eff96074c40fc2d526d6c5a47fbc7027"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_x86_64.tar.gz"
    end
  end
  #
  # Linux builds
  #
  on_linux do
    # Linux ARM (non-64) builds
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      sha256 "a961db06e40c72ea3b3827733e8999348c0789c88a24756890a3e8875e1f49dc"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_arm.tar.gz"
    end
    # Linux ARM64 builds
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      sha256 "10bf19beace0b4746fc036b9b9fefb47c1d002cb858ac1c9fc6ffcede42e068a"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_arm64.tar.gz"
    end
    # Linux Intel 64bit builds
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      sha256 "64843392278672cb3cb02d1f22496b10290cf9f7ff65f7cd48a5684ae2755963"
      url "https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_x86_64.tar.gz"
    end
  end

  def install
    bin.install "tabloid"
  end
  test do
    system "#{bin}/tabloid -v"
  end
end

# The following cache data is used by tapgen to avoid re-downloading
# GitHub release assets when they haven't changed. This improves
# performance and reduces load on GitHub servers.
# ------------------------------------------------------------------
# TAPGEN_CACHE: {"tag":"v0.0.3","repository":"patrickdappollonio/tabloid","cached_at":"2025-07-09T00:25:10.494476591-04:00","assets":[{"id":97161520,"filename":"tabloid_0.0.3_darwin_arm64.tar.gz","url":"https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_arm64.tar.gz","sha256":"46bf5f0852fdb43adea1351361e9d145405d6522786fc905c0c7612a0e9a4414"},{"id":97161519,"filename":"tabloid_0.0.3_darwin_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_darwin_x86_64.tar.gz","sha256":"c41ae387ecc4b0f070bd51afdb31ae52eff96074c40fc2d526d6c5a47fbc7027"},{"id":97161512,"filename":"tabloid_0.0.3_linux_arm.tar.gz","url":"https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_arm.tar.gz","sha256":"a961db06e40c72ea3b3827733e8999348c0789c88a24756890a3e8875e1f49dc"},{"id":97161513,"filename":"tabloid_0.0.3_linux_arm64.tar.gz","url":"https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_arm64.tar.gz","sha256":"10bf19beace0b4746fc036b9b9fefb47c1d002cb858ac1c9fc6ffcede42e068a"},{"id":97161511,"filename":"tabloid_0.0.3_linux_x86_64.tar.gz","url":"https://github.com/patrickdappollonio/tabloid/releases/download/v0.0.3/tabloid_0.0.3_linux_x86_64.tar.gz","sha256":"64843392278672cb3cb02d1f22496b10290cf9f7ff65f7cd48a5684ae2755963"}]}

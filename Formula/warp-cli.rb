class WarpCli < Formula
  desc "Beautiful CLI for Cloudflare WARP - Control your VPN from the terminal"
  homepage "https://github.com/zero8dotdev/warp-cli"
  url "https://github.com/zero8dotdev/warp-cli/archive/refs/heads/main.tar.gz"
  sha256 "5ecced8c50786200113654bca385c2daf6b868a7c35e940c0781b2580ae9dce0"
  version "0.1.0"
  license "MIT"
  head "https://github.com/zero8dotdev/warp-cli.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/warp"
  end

  def caveats
    <<~EOS
      ✅ warp-cli is installed!

      Next step: Install WARP daemon (if not already installed)
        brew install --cask cloudflare-warp

      Then start using:
        warp up          # Connect to WARP
        warp status      # Check connection
        warp --help      # See all commands
    EOS
  end

  test do
    assert_match "warp", shell_output("#{bin}/warp --version")
    assert_match "Commands:", shell_output("#{bin}/warp --help")
  end
end

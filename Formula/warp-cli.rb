class Warp < Formula
  desc "Beautiful CLI for Cloudflare WARP - Control your VPN from the terminal"
  homepage "https://github.com/zero8dotdev/warp-cli"
  url "https://github.com/zero8dotdev/warp-cli/archive/refs/heads/main.tar.gz"
  sha256 "8eee5574d09bec5960a77f312f63c3667361c9f6edea06bc7a6b24b44b81d0b0"
  license "MIT"
  head "https://github.com/zero8dotdev/warp-cli.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/warp"
  end

  def caveats
    <<~EOS
      Cloudflare WARP app must be installed first:
        brew install --cask cloudflare-warp

      Or download from: https://apps.apple.com/app/cloudflare-warp/id1423210915
    EOS
  end

  test do
    assert_match "warp", shell_output("#{bin}/warp --version")
    assert_match "Commands:", shell_output("#{bin}/warp --help")
  end
end

class WarpCli < Formula
  desc "Beautiful CLI for Cloudflare WARP - Control your VPN from the terminal"
  homepage "https://github.com/zero8dotdev/warp-cli"
  url "https://github.com/zero8dotdev/warp-cli/archive/refs/heads/main.tar.gz"
  sha256 "86c62289547feffdb8e82a7901ce6ed98a9e98fc116dde4afe84047b06887cd0"
  version "0.1.0"
  license "MIT"
  head "https://github.com/zero8dotdev/warp-cli.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/warp"
  end

  def caveats
    daemon_installed = system("launchctl list | grep -q com.cloudflare.warp.daemon")
    gui_installed = File.exist?("/Applications/Cloudflare WARP.app")

    message = ""
    message += "✅ warp-cli installed!\n\n"

    message += "📊 Installation Summary:\n"
    message += "  • Binary: warp\n"
    message += "  • Location: #{bin}/warp\n"
    message += "  • Size: ~4.4MB\n\n"

    if !daemon_installed
      message += "⚠️  WARP daemon not detected.\n"
      message += "Install it with:\n"
      message += "  brew install --cask cloudflare-warp\n\n"
    else
      message += "✅ WARP daemon is running\n\n"
    end

    if gui_installed
      message += "💡 GUI app detected at /Applications/Cloudflare WARP.app\n"
      message += "   (Not needed - this CLI doesn't use it)\n\n"
    end

    message += "🚀 Quick start:\n"
    message += "  warp up          # Connect to WARP\n"
    message += "  warp status      # Check connection + IP\n"
    message += "  warp --help      # See all commands\n\n"
    message += "📖 Learn more: https://github.com/zero8dotdev/warp-cli"

    message
  end

  test do
    assert_match "warp", shell_output("#{bin}/warp --version")
    assert_match "Commands:", shell_output("#{bin}/warp --help")
  end
end

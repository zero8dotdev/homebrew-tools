class WarpCli < Formula
  desc "Beautiful CLI for Cloudflare WARP - Control your VPN from the terminal"
  homepage "https://github.com/zero8dotdev/warp-cli"
  url "https://github.com/zero8dotdev/warp-cli/archive/refs/heads/main.tar.gz"
  sha256 "a8a9011915b13629025b47071a1713662e1fd01f3a42a57ad5d68dda84ebd8f0"
  version "0.1.0"
  license "MIT"
  head "https://github.com/zero8dotdev/warp-cli.git", branch: "main"

  depends_on "rust" => :build
  depends_on "cloudflare-warp" => :cask

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/warp"
  end

  def post_install
    # Remove the GUI app to keep things clean for CLI-only users
    gui_app = "/Applications/Cloudflare WARP.app"
    if File.exist?(gui_app)
      puts "Removing Cloudflare WARP GUI app (daemon will continue running)..."
      system "rm", "-rf", gui_app
    end
  end

  def caveats
    <<~EOS
      ✅ WARP daemon installed and configured
      ✅ GUI app removed (not needed for CLI)
      
      Your WARP daemon is running. Try it:
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

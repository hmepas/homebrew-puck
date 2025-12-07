class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.11.tar.gz"
  sha256 "e05f78bc97fbc77d26bcead1af8d89c9bd60438feeabaa3dca24a8036c993646"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/puck"
  end

  def post_install
    # Ensure config directory exists
    config_dir = File.join(Dir.home, ".config", "puck")
    mkdir_p config_dir
  end

  test do
    system "#{bin}/puck", "--version"
  end
end

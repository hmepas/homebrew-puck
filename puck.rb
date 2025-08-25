class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "0da019d297311ec7c206b4e1153e3b667e484ca3b1f69b9ab003b608317cd1b5"
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
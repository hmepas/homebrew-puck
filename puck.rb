class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "f772626d015d091928095051b38087aa1cf85c3db675dcd06f53f674282f6cef"
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
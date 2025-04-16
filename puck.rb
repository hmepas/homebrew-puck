class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "d748a9f48bad824301951a2dddee7dfc6417506b593287acf24daea1f6af08c4"
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
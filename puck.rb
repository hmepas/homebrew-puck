class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.12.tar.gz"
  sha256 "d1272d00dcd8270df99b8d1730813824eef32137d5967f5acdb4dbefec43e0fd"
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

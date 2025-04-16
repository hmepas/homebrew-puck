class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "a16585ea8bf868c56b8c6bc485ebc767043f8f08c7284b67f2aeacfc1ee23648"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/Puck"
  end

  def post_install
    # Ensure config directory exists
    (ENV["HOME"] + "/.config/puck").mkpath
  end

  test do
    system "#{bin}/Puck", "--version"
  end
end
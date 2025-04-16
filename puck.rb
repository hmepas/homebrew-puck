class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "3bfc1b9c404d26eb06c2818094784dcd0e7d0a8e9acd7e6e1b4a30718d6a6591"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    ENV["PUCK_RESOURCE_PATH"] = "#{lib}/Puck_Puck.bundle/com.puck.daemon.plist"
    
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/Puck"
    
    # Install resources
    resource_path = "#{lib}/Puck_Puck.bundle"
    mkdir_p resource_path
    cp_r Dir[".build/release/Puck_Puck.bundle/*"], resource_path
  end

  def post_install
    # Ensure config directory exists
    (ENV["HOME"] + "/.config/puck").mkpath
  end

  test do
    system "#{bin}/Puck", "--version"
  end
end
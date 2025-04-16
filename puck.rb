class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "7a40bab7e55d2deb7bbdf051589df45f99115230a7f9b5e5eaf9fde1269e94e1"
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
class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "348f854a027cc0092c8f602b3f35b87a8111b7a3136417c129e7136e2398f1de"
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
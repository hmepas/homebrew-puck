class Puck < Formula
  desc "Swift Input Method Switching Daemon for macOS"
  homepage "https://github.com/hmepas/puck"
  url "https://github.com/hmepas/puck/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "307e63f4dd5cb6780e93ee88dbc40a128af42a93e7409b22fe391c738a60d361"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", 
           "--configuration", "release",
           "--disable-sandbox",
           "PUCK_RESOURCE_PATH=#{lib}/Puck_Puck.bundle/com.puck.daemon.plist"
    
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
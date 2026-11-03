# Reel Studio. Source of truth: packaging/homebrew/reel-studio.rb in murathany7/reel-studio (update with packaging/update-formula.sh).
class ReelStudio < Formula
  desc "Make marketing reels, ads and posts with code, for any brand, with Claude Code"
  homepage "https://github.com/murathany7/reel-studio"
  url "https://registry.npmjs.org/reel-studio/-/reel-studio-0.2.0.tgz"
  sha256 "73dc3a5cc592821fafcb87a57089ac6eb1c6f4d21a720db3c01bf55009b2136e"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "node"

  on_linux do
    depends_on "rsync"
  end

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Rendering also needs Google Chrome (or set CHROME_PATH). Blender is optional, for 3D plates.
      Start a project with:
        reel-studio init
    EOS
  end

  test do
    assert_match "Reel Studio", shell_output("#{bin}/reel-studio help")
    system bin/"reel-studio", "init", testpath/"proj"
    assert_path_exists testpath/"proj/core/render.mjs"
    assert_path_exists testpath/"proj/.claude/skills/make-video/SKILL.md"
  end
end

class Gospeak < Formula
  desc "CLI for text-to-speech using OpenAI, ElevenLabs, or Deepgram TTS API - no ffmpeg required"
  homepage "https://github.com/schappim/gospeak"
  url "https://github.com/schappim/gospeak/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "07c7cc2f912bce0b577c724bb95c69acc6e8bcca846d13722bc560a6a9172c6f"
  license "MIT"
  head "https://github.com/schappim/gospeak.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "gospeak", shell_output("#{bin}/gospeak --help")
    assert_match "elevenlabs", shell_output("#{bin}/gospeak --help")
    assert_match "deepgram", shell_output("#{bin}/gospeak --help")
  end
end

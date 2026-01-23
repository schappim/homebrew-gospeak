class Gospeak < Formula
  desc "CLI for text-to-speech using OpenAI, ElevenLabs, or Deepgram TTS API - no ffmpeg required"
  homepage "https://github.com/schappim/gospeak"
  url "https://github.com/schappim/gospeak/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "f40c3d2209093b963346efec69dc53e395e3617fec73974f3ed697645b2a38ef"
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

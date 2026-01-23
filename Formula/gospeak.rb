class Gospeak < Formula
  desc "CLI for text-to-speech using OpenAI or ElevenLabs TTS API - no ffmpeg required"
  homepage "https://github.com/schappim/gospeak"
  url "https://github.com/schappim/gospeak/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "46419da256174bb3c4021bf7ff5ef79a8fd721d4b0c7006c1a0b40ae2f7c59a9"
  license "MIT"
  head "https://github.com/schappim/gospeak.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "gospeak", shell_output("#{bin}/gospeak --help")
    assert_match "elevenlabs", shell_output("#{bin}/gospeak --help")
  end
end

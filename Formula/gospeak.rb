class Gospeak < Formula
  desc "CLI for text-to-speech and sound effects via OpenAI, ElevenLabs, or Deepgram"
  homepage "https://github.com/schappim/gospeak"
  url "https://github.com/schappim/gospeak/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "9c25b6887c168212928459501cca74647bc5f73d7fa9ab592bd9fe45b23dd4f8"
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
    assert_match "--sfx", shell_output("#{bin}/gospeak --help")
  end
end

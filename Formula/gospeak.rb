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
    # gospeak writes its usage to stderr, so it has to be folded into stdout
    # for shell_output to see it at all.
    help = shell_output("#{bin}/gospeak --help 2>&1")
    assert_match "gospeak", help
    assert_match "elevenlabs", help
    assert_match "deepgram", help
    assert_match "--sfx", help

    # A missing API key is the one error path reachable without credentials.
    no_key = shell_output("#{bin}/gospeak --sfx 'a bell' 2>&1", 1)
    assert_match "ELEVENLABS_API_KEY", no_key
  end
end

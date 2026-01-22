class Gospeak < Formula
  desc "CLI for text-to-speech using OpenAI's TTS API - no ffmpeg required"
  homepage "https://github.com/schappim/gospeak"
  url "https://github.com/schappim/gospeak/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5383b541a2c309b1e12739e8c7d3b56b214bd92a8135623b03c006ec900c38f9"
  license "MIT"
  head "https://github.com/schappim/gospeak.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "gospeak", shell_output("#{bin}/gospeak --help")
  end
end

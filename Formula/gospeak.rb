class Gospeak < Formula
  desc "CLI for text-to-speech and sound effects via OpenAI, ElevenLabs, or Deepgram"
  homepage "https://github.com/schappim/gospeak"
  url "https://github.com/schappim/gospeak/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "916dc05b6adba46990c49aa526cfced9b23dd32583cfe1c11b1c3f4941759bf1"
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
    assert_match "--config", help

    # The config file selects a provider, and a missing API key is the one error
    # path reachable without credentials — so the key gospeak asks for is proof
    # of which provider it settled on. The keys are cleared explicitly so the
    # test still means something when run on a machine that has them exported,
    # and GOSPEAK_CONFIG keeps it off any real ~/.gospeak.json.
    (testpath/"gospeak.json").write <<~JSON
      {"provider": "deepgram", "providers": {"deepgram": {"voice": "thalia"}}}
    JSON

    with_env(OPENAI_API_KEY: nil, ELEVENLABS_API_KEY: nil, DEEPGRAM_API_KEY: nil,
             GOSPEAK_CONFIG: (testpath/"gospeak.json").to_s) do
      assert_match "DEEPGRAM_API_KEY", shell_output("#{bin}/gospeak 'hello' 2>&1", 1)

      # --no-config has to put the built-in default back.
      assert_match "OPENAI_API_KEY",
                   shell_output("#{bin}/gospeak --no-config 'hello' 2>&1", 1)

      # --sfx picks ElevenLabs on its own, over a config file naming another one.
      assert_match "ELEVENLABS_API_KEY",
                   shell_output("#{bin}/gospeak --sfx 'a bell' 2>&1", 1)
    end
  end
end

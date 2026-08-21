# Homebrew Tap for gospeak

This is the official Homebrew tap for [gospeak](https://github.com/schappim/gospeak) - a Go CLI for text-to-speech using OpenAI, ElevenLabs, or Deepgram TTS API, with no ffmpeg required.

## Installation

```bash
# Add the tap
brew tap schappim/gospeak

# Install gospeak
brew install gospeak

# Upgrade to latest version
brew upgrade gospeak
```

## Quick Start

```bash
# Set your API key(s)
export OPENAI_API_KEY="your-openai-api-key"
export ELEVENLABS_API_KEY="your-elevenlabs-api-key"  # optional
export DEEPGRAM_API_KEY="your-deepgram-api-key"  # optional

# Speak text directly (uses OpenAI by default)
gospeak "Hello, world!"

# Pipe text from another command
echo "Hello from the command line" | gospeak
```

## Providers

gospeak supports three TTS providers:

### OpenAI (default)

```bash
gospeak "Hello with OpenAI"
gospeak -v nova "Using nova voice"
gospeak -v cedar "Using cedar, one of the newest voices"
```

`ballad`, `verse`, `marin` and `cedar` only exist on the `gpt-4o-mini-tts` model.
gospeak selects it for them automatically, so no `-m` is needed.

### ElevenLabs

```bash
gospeak -p elevenlabs "Hello from ElevenLabs"
gospeak -p elevenlabs -v josh "Using Josh's voice"
gospeak -p elevenlabs -v rachel "Using Rachel's voice"
```

### Deepgram

```bash
gospeak -p deepgram "Hello from Deepgram"
gospeak -p deepgram -v asteria "Using Asteria voice"
gospeak -p deepgram -v thalia "Using Thalia voice (Aura 2)"
```

## Config File

Set your default provider and voice once in `~/.gospeak.json` instead of typing
them on every run:

```json
{
  "provider": "elevenlabs",
  "voice": "josh",

  "providers": {
    "openai":   { "voice": "nova" },
    "deepgram": { "voice": "thalia" }
  }
}
```

`gospeak "Hello"` now speaks with Josh on ElevenLabs. Anything you type on the
command line still beats the file, and a `providers` entry beats the file-wide
setting for that provider. `provider`, `voice`, `model` and `speed` are all
supported; API keys stay in environment variables.

```bash
# Point at a different file for one run
gospeak --config ./project-voice.json "Hello"

# Or ignore the file entirely
gospeak --no-config "Hello"
```

## Sound Effects

```bash
# Describe the sound instead of speaking text - picks ElevenLabs by itself
gospeak --sfx "distant thunder rolling across a valley"

# Pin the length (0.5-30 seconds) and make it loop seamlessly
gospeak --sfx -d 10 --loop -o rain.mp3 "steady rain on a tin roof"
```

## Usage

```bash
# Choose a voice
# OpenAI: alloy, ash, ballad, coral, echo, fable, nova, onyx, sage, shimmer, verse, marin, cedar
# ElevenLabs: rachel, domi, bella, antoni, elli, josh, arnold, adam, sam, george, charlie, emily, lily, michael
# Deepgram: asteria, luna, stella, athena, hera, orion, arcas, perseus, angus, orpheus, helios, zeus
# Deepgram Aura 2: thalia, andromeda, helena, jason, apollo, ares
gospeak -v nova "Hello with nova"
gospeak -v marin "OpenAI rates marin and cedar the best of the roster"
gospeak -p elevenlabs -v josh "Hello with Josh"
gospeak -p deepgram -v asteria "Hello with Asteria"

# Hear all OpenAI voices demo
gospeak --all "The quick brown fox jumps over the lazy dog"

# Save to MP3
gospeak -o output.mp3 "Save this to a file"

# Save and play
gospeak -o output.mp3 -s "Save and speak at the same time"

# Adjust speed
# OpenAI: 0.25 to 4.0
# ElevenLabs: 0.7 to 1.2
gospeak -x 1.5 "Speaking faster"
gospeak -p elevenlabs -x 0.8 "Speaking slower"

# ElevenLabs voice settings
gospeak -p elevenlabs --stability 0.8 "More stable voice"
gospeak -p elevenlabs --similarity 0.9 "Higher similarity"

# Use different models
gospeak -m tts-1 "Standard OpenAI model"
gospeak -m gpt-4o-mini-tts -v cedar "Newest model, speaks all 13 voices"
gospeak -p elevenlabs -m eleven_turbo_v2_5 "Turbo ElevenLabs model"
```

## Options

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--provider` | `-p` | TTS provider (`openai`, `elevenlabs`, `deepgram`) | `openai` |
| `--voice` | `-v` | Voice to use | Provider-specific |
| `--model` | `-m` | Model to use | Provider-specific |
| `--output` | `-o` | Save audio to file | - |
| `--speed` | `-x` | Speech speed | `1.0` |
| `--speak` | `-s` | Play audio even when saving | `false` |
| `--token` | - | API key | From env var |
| `--all` | - | Speak with all voices (OpenAI) | `false` |
| `--stability` | - | Voice stability (ElevenLabs) | `0.5` |
| `--similarity` | - | Similarity boost (ElevenLabs) | `0.75` |
| `--sfx` | - | Generate a sound effect instead of speech (ElevenLabs) | `false` |
| `--duration` | `-d` | Sound effect length in seconds, 0.5-30 (`--sfx` only) | model decides |
| `--influence` | - | Prompt adherence, 0.0-1.0 (`--sfx` only) | `0.3` |
| `--loop` | - | Make the sound effect loop seamlessly (`--sfx` only) | `false` |
| `--config` | - | Path to a config file | `~/.gospeak.json` |
| `--no-config` | - | Ignore the config file | `false` |
| `--help` | `-h` | Show help message | - |

## Scripting Examples

```bash
# Read a file aloud
cat article.txt | gospeak

# Speak command output
date | gospeak -v nova

# Use with LLM output
llm "Tell me a joke" | gospeak -v nova
llm "Tell me a story" | gospeak -p elevenlabs -v josh
llm "Tell me a fact" | gospeak -p deepgram -v asteria

# Compare providers
gospeak "Hello world"
gospeak -p elevenlabs "Hello world"
gospeak -p deepgram "Hello world"
```

## Documentation

For complete documentation and more examples, see the [gospeak README](https://github.com/schappim/gospeak).

## License

MIT License

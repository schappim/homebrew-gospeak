# Homebrew Tap for gospeak

This is the official Homebrew tap for [gospeak](https://github.com/schappim/gospeak) - a Go CLI for text-to-speech using OpenAI's TTS API, with no ffmpeg required.

## Installation

```bash
# Add the tap
brew tap schappim/gospeak

# Install gospeak
brew install gospeak
```

## Quick Start

```bash
# Set your OpenAI API key
export OPENAI_API_KEY="your-api-key-here"

# Speak text directly
gospeak "Hello, world!"

# Pipe text from another command
echo "Hello from the command line" | gospeak
```

## Usage

```bash
# Choose a voice (alloy, echo, fable, onyx, nova, shimmer)
gospeak -v nova "Hello with the nova voice"

# Hear all voices demo
gospeak --all "The quick brown fox jumps over the lazy dog"

# Save to MP3
gospeak -o output.mp3 "Save this to a file"

# Save and play
gospeak -o output.mp3 -s "Save and speak at the same time"

# Adjust speed (0.25 to 4.0)
gospeak -x 1.5 "Speaking faster"

# Use standard model (faster, lower quality)
gospeak -m tts-1 "Standard quality"
```

## Options

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--voice` | `-v` | Voice to use | `alloy` |
| `--model` | `-m` | Model (`tts-1`, `tts-1-hd`) | `tts-1-hd` |
| `--output` | `-o` | Save audio to file | - |
| `--speed` | `-x` | Speech speed (0.25-4.0) | `1.0` |
| `--speak` | `-s` | Play audio even when saving | `false` |
| `--token` | - | OpenAI API key | `$OPENAI_API_KEY` |
| `--all` | - | Speak with all voices | `false` |

## Scripting Examples

```bash
# Read a file aloud
cat article.txt | gospeak

# Speak command output
date | gospeak -v nova

# Use with LLM output
llm "Tell me a joke" | gospeak -v echo
```

## Documentation

For complete documentation and more examples, see the [gospeak README](https://github.com/schappim/gospeak).

## License

MIT License

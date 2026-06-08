#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  local_transcribe.sh <audio-file> [output-prefix]

Environment:
  WHISPER_MODEL   Model path. Defaults to ~/.local/share/whisper.cpp/models/ggml-small-q5_1.bin
  WHISPER_LANG    Spoken language. Defaults to zh
  WHISPER_THREADS Thread count. Defaults to 8

Outputs:
  <output-prefix>.txt
  <output-prefix>.srt
  <output-prefix>.json
USAGE
}

if [[ $# -lt 1 || "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

audio_file="$1"
if [[ ! -f "$audio_file" ]]; then
  echo "Audio file not found: $audio_file" >&2
  exit 1
fi

if ! command -v whisper-cli >/dev/null 2>&1; then
  echo "whisper-cli not found. Install whisper.cpp first." >&2
  exit 1
fi

model_path="${WHISPER_MODEL:-$HOME/.local/share/whisper.cpp/models/ggml-small-q5_1.bin}"
if [[ ! -f "$model_path" ]]; then
  echo "Model not found: $model_path" >&2
  echo "Download one from https://huggingface.co/ggerganov/whisper.cpp/tree/main" >&2
  exit 1
fi

lang="${WHISPER_LANG:-zh}"
threads="${WHISPER_THREADS:-8}"

if [[ $# -ge 2 ]]; then
  output_prefix="$2"
else
  dir="$(dirname "$audio_file")"
  base="$(basename "$audio_file")"
  output_prefix="$dir/${base%.*}-本地转写"
fi

whisper-cli \
  -m "$model_path" \
  -f "$audio_file" \
  -l "$lang" \
  -t "$threads" \
  -sns \
  -nf \
  -nth 0.80 \
  -otxt \
  -osrt \
  -oj \
  -of "$output_prefix"

echo "Saved:"
echo "  $output_prefix.txt"
echo "  $output_prefix.srt"
echo "  $output_prefix.json"

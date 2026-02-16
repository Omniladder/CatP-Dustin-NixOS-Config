#!/bin/sh
# Set volume to percentage (0-100)
# Usage: set_volume.sh <percentage>

percentage="$1"
if [ -z "$percentage" ]; then
  exit 1
fi

# Try pactl (PulseAudio) first
if command -v pactl >/dev/null 2>&1; then
  if pactl set-sink-volume @DEFAULT_SINK@ "${percentage}%" >/dev/null 2>&1; then
    exit 0
  fi
fi

# Try wpctl (WirePlumber)
if command -v wpctl >/dev/null 2>&1; then
  # Convert percentage to decimal (e.g., 50 -> 0.50)
  decimal=$(awk "BEGIN {printf \"%.2f\", $percentage / 100}")
  if wpctl set-volume @DEFAULT_AUDIO_SINK@ "$decimal" >/dev/null 2>&1; then
    exit 0
  fi
fi

# Try amixer (ALSA)
if command -v amixer >/dev/null 2>&1; then
  # Try Master first, then PCM
  for control in Master PCM; do
    if amixer set "$control" "${percentage}%" >/dev/null 2>&1; then
      exit 0
    fi
  done
fi

exit 1


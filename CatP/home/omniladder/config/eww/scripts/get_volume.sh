#!/bin/sh
# Get current volume as percentage (0-100)

# Try pactl (PulseAudio) first
if command -v pactl >/dev/null 2>&1; then
  # Get default sink volume
  volume_info=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | head -n1)
  if [ -n "$volume_info" ]; then
    # Extract percentage (format: "Volume: front-left: 50% ...")
    volume=$(echo "$volume_info" | grep -oE '[0-9]+%' | head -n1 | tr -d '%')
    if [ -n "$volume" ]; then
      echo "$volume"
      exit 0
    fi
  fi
fi

# Try wpctl (WirePlumber)
if command -v wpctl >/dev/null 2>&1; then
  volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
  if [ -n "$volume_info" ]; then
    # Extract percentage (format: "Volume: 0.50" -> 50%)
    volume=$(echo "$volume_info" | grep -oE '[0-9]+\.[0-9]+' | head -n1 | awk '{printf "%.0f", $1 * 100}')
    if [ -n "$volume" ]; then
      echo "$volume"
      exit 0
    fi
  fi
fi

# Try amixer (ALSA)
if command -v amixer >/dev/null 2>&1; then
  # Try Master first, then PCM
  for control in Master PCM; do
    volume_info=$(amixer get "$control" 2>/dev/null | grep -oE '[0-9]+%' | head -n1 | tr -d '%')
    if [ -n "$volume_info" ]; then
      echo "$volume_info"
      exit 0
    fi
  done
fi

# Fallback: return 50 if nothing works
echo "50"
exit 1


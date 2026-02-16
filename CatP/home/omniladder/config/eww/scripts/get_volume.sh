
#!/bin/sh

# Try wpctl (PipeWire) first
if command -v wpctl >/dev/null 2>&1; then
  wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null \
    | awk '{printf "%.0f\n", $2 * 100}'
  exit 0
fi

# Fallback to pactl (PulseAudio)
if command -v pactl >/dev/null 2>&1; then
  pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null \
    | grep -oE '[0-9]+%' \
    | head -n1 \
    | tr -d '%'
  exit 0
fi

# If nothing works, return 0
echo '0'

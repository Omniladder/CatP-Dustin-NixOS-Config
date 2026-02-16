#!/bin/sh
# Get current brightness as percentage (0-100)

# Try brightnessctl first (most common on modern systems)
if command -v brightnessctl >/dev/null 2>&1; then
  brightness=$(brightnessctl get 2>/dev/null)
  max=$(brightnessctl max 2>/dev/null)
  if [ -n "$brightness" ] && [ -n "$max" ] && [ "$max" -gt 0 ]; then
    echo "$((brightness * 100 / max))"
    exit 0
  fi
fi

# Try light command
if command -v light >/dev/null 2>&1; then
  brightness=$(light -G 2>/dev/null | cut -d. -f1)
  if [ -n "$brightness" ]; then
    echo "$brightness"
    exit 0
  fi
fi

# Try xbacklight
if command -v xbacklight >/dev/null 2>&1; then
  brightness=$(xbacklight -get 2>/dev/null | cut -d. -f1)
  if [ -n "$brightness" ]; then
    echo "$brightness"
    exit 0
  fi
fi

# Try sysfs directly
if [ -d /sys/class/backlight ]; then
  for backlight in /sys/class/backlight/*; do
    if [ -f "$backlight/brightness" ] && [ -f "$backlight/max_brightness" ]; then
      brightness=$(cat "$backlight/brightness" 2>/dev/null)
      max=$(cat "$backlight/max_brightness" 2>/dev/null)
      if [ -n "$brightness" ] && [ -n "$max" ] && [ "$max" -gt 0 ]; then
        echo "$((brightness * 100 / max))"
        exit 0
      fi
    fi
  done
fi

# Fallback: return 50 if nothing works
echo "50"
exit 1


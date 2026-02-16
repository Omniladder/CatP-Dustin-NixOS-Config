#!/bin/sh
# Set brightness to percentage (0-100)
# Usage: set_brightness.sh <percentage>

percentage="$1"
if [ -z "$percentage" ]; then
  exit 1
fi

# Try brightnessctl first
if command -v brightnessctl >/dev/null 2>&1; then
  if brightnessctl set "${percentage}%" >/dev/null 2>&1; then
    exit 0
  fi
fi

# Try light command
if command -v light >/dev/null 2>&1; then
  if light -S "$percentage" >/dev/null 2>&1; then
    exit 0
  fi
fi

# Try xbacklight
if command -v xbacklight >/dev/null 2>&1; then
  if xbacklight -set "$percentage" >/dev/null 2>&1; then
    exit 0
  fi
fi

# Try sysfs directly
if [ -d /sys/class/backlight ]; then
  for backlight in /sys/class/backlight/*; do
    if [ -f "$backlight/brightness" ] && [ -f "$backlight/max_brightness" ]; then
      max=$(cat "$backlight/max_brightness" 2>/dev/null)
      if [ -n "$max" ] && [ "$max" -gt 0 ]; then
        new_brightness=$((percentage * max / 100))
        echo "$new_brightness" > "$backlight/brightness" 2>/dev/null && exit 0
      fi
    fi
  done
fi

exit 1


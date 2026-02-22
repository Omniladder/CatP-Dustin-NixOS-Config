#!/bin/sh

# Get brightness as percentage (0-100)

# Try brightnessctl first (most common on Linux laptops)
if command -v brightnessctl >/dev/null 2>&1; then
  # brightnessctl -m outputs: device,class,cur,max,unit
  out=$(brightnessctl -m 2>/dev/null | head -n1)
  cur=$(printf "%s" "$out" | awk -F, '{print $3}')
  max=$(printf "%s" "$out" | awk -F, '{print $4}')
  if [ -n "$cur" ] && [ -n "$max" ] && [ "$max" -gt 0 ] 2>/dev/null; then
    awk "BEGIN { printf \"%.0f\n\", ($cur / $max) * 100 }"
    exit 0
  fi
fi

# Try light
if command -v light >/dev/null 2>&1; then
  # light -G returns brightness percent (may be float)
  val=$(light -G 2>/dev/null)
  if [ -n "$val" ]; then
    awk "BEGIN { printf \"%.0f\n\", $val }"
    exit 0
  fi
fi

# Try xbacklight (X11 only)
if command -v xbacklight >/dev/null 2>&1; then
  val=$(xbacklight -get 2>/dev/null)
  if [ -n "$val" ]; then
    awk "BEGIN { printf \"%.0f\n\", $val }"
    exit 0
  fi
fi

# Fallback: sysfs backlight
if [ -d /sys/class/backlight ]; then
  for backlight in /sys/class/backlight/*; do
    if [ -f "$backlight/brightness" ] && [ -f "$backlight/max_brightness" ]; then
      cur=$(cat "$backlight/brightness" 2>/dev/null)
      max=$(cat "$backlight/max_brightness" 2>/dev/null)
      if [ -n "$cur" ] && [ -n "$max" ] && [ "$max" -gt 0 ] 2>/dev/null; then
        awk "BEGIN { printf \"%.0f\n\", ($cur / $max) * 100 }"
        exit 0
      fi
    fi
  done
fi

exit 1

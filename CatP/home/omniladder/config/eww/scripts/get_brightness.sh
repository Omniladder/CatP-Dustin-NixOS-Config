#!/bin/sh

if command -v wpctl >/dev/null 2>&1; then
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print $2}')
  [ -n "$vol" ] && awk "BEGIN { printf \"%.0f\n\", $vol * 100 }" && exit 0
fi

if command -v pactl >/dev/null 2>&1; then
  vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oE '[0-9]+%' | head -n1 | tr -d '%')
  [ -n "$vol" ] && echo "$vol" && exit 0
fi

echo 0

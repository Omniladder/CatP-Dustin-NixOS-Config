#!/bin/sh
# Get battery percentage in format "Battery: XX%"

# Try sysfs first (most direct method)
if [ -d /sys/class/power_supply ]; then
  for battery in /sys/class/power_supply/BAT*; do
    if [ -f "$battery/capacity" ]; then
      capacity=$(cat "$battery/capacity" 2>/dev/null)
      if [ -n "$capacity" ]; then
        echo "Battery: ${capacity}%"
        exit 0
      fi
    fi
  done
fi

# Try upower
if command -v upower >/dev/null 2>&1; then
  battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 2>/dev/null | grep -E "percentage" | grep -oE '[0-9]+%')
  if [ -n "$battery_info" ]; then
    capacity=$(echo "$battery_info" | tr -d '%')
    echo "Battery: ${capacity}%"
    exit 0
  fi
fi

# Try acpi
if command -v acpi >/dev/null 2>&1; then
  battery_info=$(acpi -b 2>/dev/null | grep -oE '[0-9]+%' | head -n1)
  if [ -n "$battery_info" ]; then
    capacity=$(echo "$battery_info" | tr -d '%')
    echo "Battery: ${capacity}%"
    exit 0
  fi
fi

# Fallback
echo "Battery: N/A"
exit 1


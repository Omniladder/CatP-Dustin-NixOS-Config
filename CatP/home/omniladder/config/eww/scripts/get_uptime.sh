#!/bin/sh
# Get uptime in format "Uptime: Xd Xh Xm"

# Try /proc/uptime first
if [ -f /proc/uptime ]; then
  uptime_seconds=$(awk '{print int($1)}' /proc/uptime 2>/dev/null)
  
  if [ -n "$uptime_seconds" ] && [ "$uptime_seconds" -gt 0 ]; then
    days=$((uptime_seconds / 86400))
    hours=$(( (uptime_seconds % 86400) / 3600 ))
    minutes=$(( (uptime_seconds % 3600) / 60 ))
    
    echo "Uptime: ${days}d ${hours}h ${minutes}m"
    exit 0
  fi
fi

# Fallback: try uptime command
if command -v uptime >/dev/null 2>&1; then
  uptime_output=$(uptime -p 2>/dev/null)
  if [ -n "$uptime_output" ]; then
    # Convert "up X days, Y hours, Z minutes" to "Uptime: Xd Yh Zm"
    formatted=$(echo "$uptime_output" | sed 's/up //' | sed 's/ day\(s\)\?/d/g' | sed 's/ hour\(s\)\?/h/g' | sed 's/ minute\(s\)\?/m/g' | sed 's/, //g')
    echo "Uptime: $formatted"
    exit 0
  fi
fi

# Fallback
echo "Uptime: N/A"
exit 1


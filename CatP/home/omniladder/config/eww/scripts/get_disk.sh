#!/bin/sh
# Get disk usage in format "Disk: XXXGB/XXXGB"

# Get root filesystem usage
if command -v df >/dev/null 2>&1; then
  # Get root filesystem (/) usage
  disk_info=$(df -BG / 2>/dev/null | tail -n1)
  if [ -n "$disk_info" ]; then
    used=$(echo "$disk_info" | awk '{print $3}' | sed 's/G$//')
    total=$(echo "$disk_info" | awk '{print $2}' | sed 's/G$//')
    
    if [ -n "$used" ] && [ -n "$total" ]; then
      echo "Disk: ${used}GB/${total}GB"
      exit 0
    fi
  fi
fi

# Fallback: try df -h and parse
if command -v df >/dev/null 2>&1; then
  disk_info=$(df -h / 2>/dev/null | tail -n1)
  if [ -n "$disk_info" ]; then
    used=$(echo "$disk_info" | awk '{print $3}')
    total=$(echo "$disk_info" | awk '{print $2}')
    
    if [ -n "$used" ] && [ -n "$total" ]; then
      echo "Disk: ${used}/${total}"
      exit 0
    fi
  fi
fi

# Fallback
echo "Disk: N/A"
exit 1


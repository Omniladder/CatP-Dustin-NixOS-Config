#!/bin/sh
# Get RAM usage in format "RAM: X.XGB/XXGB"

# Parse /proc/meminfo
if [ -f /proc/meminfo ]; then
  mem_total=$(grep "^MemTotal:" /proc/meminfo | awk '{print $2}')
  mem_available=$(grep "^MemAvailable:" /proc/meminfo | awk '{print $2}')
  
  if [ -n "$mem_total" ] && [ -n "$mem_available" ]; then
    # Calculate used memory (in KB)
    mem_used=$((mem_total - mem_available))
    
    # Convert to GB (1 GB = 1048576 KB)
    total_gb=$(awk "BEGIN {printf \"%.1f\", $mem_total / 1048576}")
    used_gb=$(awk "BEGIN {printf \"%.1f\", $mem_used / 1048576}")
    
    # Format: remove .0 if it's a whole number
    total_formatted=$(echo "$total_gb" | sed 's/\.0$//')
    used_formatted=$(echo "$used_gb" | sed 's/\.0$//')
    
    echo "RAM: ${used_formatted}GB/${total_formatted}GB"
    exit 0
  fi
fi

# Fallback
echo "RAM: N/A"
exit 1


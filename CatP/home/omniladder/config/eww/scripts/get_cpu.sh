#!/bin/sh
# Get CPU usage in format "CPU: XX%"
# Requires state tracking for calculation

cache_file="/tmp/eww_cpu_prev"

# Parse /proc/stat for CPU line
if [ -f /proc/stat ]; then
  cpu_line=$(grep "^cpu " /proc/stat)
  if [ -n "$cpu_line" ]; then
    # Extract CPU times: user, nice, system, idle, iowait, irq, softirq, steal
    user=$(echo "$cpu_line" | awk '{print $2}')
    nice=$(echo "$cpu_line" | awk '{print $3}')
    system=$(echo "$cpu_line" | awk '{print $4}')
    idle=$(echo "$cpu_line" | awk '{print $5}')
    iowait=$(echo "$cpu_line" | awk '{print $6}')
    irq=$(echo "$cpu_line" | awk '{print $7}')
    softirq=$(echo "$cpu_line" | awk '{print $8}')
    steal=$(echo "$cpu_line" | awk '{print $9}')
    
    # Calculate total and idle
    idle_total=$((idle + iowait))
    total=$((user + nice + system + idle + iowait + irq + softirq + steal))
    
    if [ -f "$cache_file" ]; then
      # Read previous values
      prev_line=$(cat "$cache_file" 2>/dev/null)
      if [ -n "$prev_line" ]; then
        prev_idle=$(echo "$prev_line" | awk '{print $1}')
        prev_total=$(echo "$prev_line" | awk '{print $2}')
        
        if [ -n "$prev_idle" ] && [ -n "$prev_total" ]; then
          # Calculate difference
          idle_diff=$((idle_total - prev_idle))
          total_diff=$((total - prev_total))
          
          if [ "$total_diff" -gt 0 ]; then
            # Calculate usage percentage
            usage=$((100 * (total_diff - idle_diff) / total_diff))
            echo "CPU: ${usage}%"
            
            # Save current values
            echo "$idle_total $total" > "$cache_file"
            exit 0
          fi
        fi
      fi
    fi
    
    # First run or cache invalid - save values and return 0%
    echo "$idle_total $total" > "$cache_file"
    echo "CPU: 0%"
    exit 0
  fi
fi

# Fallback
echo "CPU: N/A"
exit 1


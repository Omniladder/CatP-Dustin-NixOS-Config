#!/bin/sh
# Get network download speed from speed test in format "Down: ↓ X.XMB/s"
# Runs speed test periodically and caches results

cache_file="/tmp/eww_net_speed_prev"
test_interval=120  # Run test every 2 minutes (120 seconds)
current_time=$(date +%s)

# Check if we need to run a new test
run_test=false

if [ -f "$cache_file" ]; then
  # Read cached values: format: "upload_mbps download_mbps timestamp"
  # Use a lock to ensure we read the latest value
  prev_line=$(cat "$cache_file" 2>/dev/null)
  if [ -n "$prev_line" ]; then
    prev_time=$(echo "$prev_line" | awk '{print $3}')
    if [ -n "$prev_time" ]; then
      time_diff=$((current_time - prev_time))
      if [ "$time_diff" -ge "$test_interval" ]; then
        run_test=true
      else
        # Return cached download speed (field 2)
        download_mbps=$(echo "$prev_line" | awk '{print $2}')
        if [ -n "$download_mbps" ] && [ "$download_mbps" != "0" ] && [ "$download_mbps" != "0.0" ]; then
          echo "Down: ↓ ${download_mbps}MB/s"
          exit 0
        fi
      fi
    fi
  else
    run_test=true
  fi
else
  run_test=true
fi

# Run speed test if needed
if [ "$run_test" = true ]; then
  # Check if a test is already running
  test_lock="/tmp/eww_net_speed_test.lock"
  if [ -f "$test_lock" ]; then
    # Test is running, return cached value or "Testing..."
    if [ -f "$cache_file" ]; then
      prev_line=$(cat "$cache_file" 2>/dev/null)
      if [ -n "$prev_line" ]; then
        download_mbps=$(echo "$prev_line" | awk '{print $2}')
        if [ -n "$download_mbps" ] && [ "$download_mbps" != "0" ]; then
          echo "Down: ↓ ${download_mbps}MB/s"
          exit 0
        fi
      fi
    fi
    echo "Down: ↓ Testing..."
    exit 0
  fi
  
  # Try to create lock file atomically
  if (umask 077; echo "$$" > "$test_lock" 2>/dev/null); then
    # Successfully created lock, we'll run the test
    :
  else
    # Lock already exists, another process is running the test
    if [ -f "$cache_file" ]; then
      prev_line=$(cat "$cache_file" 2>/dev/null)
      if [ -n "$prev_line" ]; then
        download_mbps=$(echo "$prev_line" | awk '{print $2}')
        if [ -n "$download_mbps" ] && [ "$download_mbps" != "0" ]; then
          echo "Down: ↓ ${download_mbps}MB/s"
          exit 0
        fi
      fi
    fi
    echo "Down: ↓ Testing..."
    exit 0
  fi
  
  # Try speedtest-cli (Ookla Speedtest)
  if command -v speedtest-cli >/dev/null 2>&1; then
    # Run speed test (this takes 10-30 seconds)
    # Use --simple for simpler output, or --json for structured data
    test_result=$(speedtest-cli --simple 2>/dev/null)
    
    if [ -n "$test_result" ]; then
      # Extract download speed (format: "Download: XX.XX Mbit/s")
      download_mbps=$(echo "$test_result" | grep -i "Download" | awk '{print $2}')
      
      # Extract upload speed (format: "Upload: XX.XX Mbit/s")
      upload_mbps=$(echo "$test_result" | grep -i "Upload" | awk '{print $2}')
      
      if [ -n "$download_mbps" ] && [ -n "$upload_mbps" ]; then
        # Convert Mbit/s to MB/s (1 Mbit = 0.125 MB)
        download_mb=$(awk "BEGIN {printf \"%.1f\", $download_mbps * 0.125}")
        upload_mb=$(awk "BEGIN {printf \"%.1f\", $upload_mbps * 0.125}")
        
        # Validate that we got reasonable values (both should be > 0)
        if [ -n "$upload_mb" ] && [ -n "$download_mb" ] && [ "$upload_mb" != "0.0" ] && [ "$download_mb" != "0.0" ]; then
          # Cache results: format is "upload_mb download_mb timestamp"
          # Write atomically to prevent partial reads
          echo "$upload_mb $download_mb $current_time" > "${cache_file}.tmp" && mv "${cache_file}.tmp" "$cache_file"
          
          # Remove lock file
          rm -f "$test_lock"
          
          echo "Down: ↓ ${download_mb}MB/s"
          exit 0
        fi
      fi
    fi
  fi
  
  # Try fast-cli (Netflix fast.com) as fallback
  if command -v fast-cli >/dev/null 2>&1; then
    test_result=$(fast-cli --json 2>/dev/null)
    
    if [ -n "$test_result" ]; then
      # fast-cli provides download speed
      download_mb=$(echo "$test_result" | grep -oE '"speed":[0-9.]+' | cut -d: -f2)
      
      if [ -n "$download_mb" ]; then
        # fast-cli gives speed in Mbps, convert to MB/s
        download_mb=$(awk "BEGIN {printf \"%.1f\", $download_mb * 0.125}")
      else
        download_mb="0.0"
      fi
      
      # Cache upload as 0 (fast-cli doesn't test upload)
      upload_mb="0.0"
      
      # Cache results
      echo "$upload_mb $download_mb $current_time" > "$cache_file"
      
      # Remove lock file
      rm -f "$test_lock"
      
      echo "Down: ↓ ${download_mb}MB/s"
      exit 0
    fi
  fi
  
  # If no speed test tool available, return cached value or 0
  rm -f "$test_lock"
  if [ -f "$cache_file" ]; then
    prev_line=$(cat "$cache_file" 2>/dev/null)
    if [ -n "$prev_line" ]; then
      download_mbps=$(echo "$prev_line" | awk '{print $2}')
      if [ -n "$download_mbps" ]; then
        echo "Down: ↓ ${download_mbps}MB/s"
        exit 0
      fi
    fi
  fi
  
  echo "Down: ↓ N/A"
  exit 1
fi

# Fallback
echo "Down: ↓ 0.0MB/s"
exit 1


#!/bin/sh
set -eu

# Location (cached 12h)
cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/eww-weather-loc"
ttl=$((12 * 60 * 60))
now=$(date +%s)

age=$((ttl + 1))
if [ -f "$cache_file" ]; then
  cache_time=$(stat -c %Y "$cache_file" 2>/dev/null || echo 0)
  age=$((now - cache_time))
fi

if [ "$age" -lt "$ttl" ]; then
  read lat lon < "$cache_file"
else
  loc=$(curl -fsS https://ipinfo.io/loc)   # "lat,lon"
  lat=${loc%,*}
  lon=${loc#*,}
  mkdir -p "$(dirname "$cache_file")"
  printf "%s %s\n" "$lat" "$lon" > "$cache_file"
fi

# Get today's sunrise and print only the time (HH:MM)
json=$(curl -fsS "https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&daily=sunrise&timezone=auto")

if command -v jq >/dev/null 2>&1; then
  sunrise=$(printf "%s" "$json" | jq -r '.daily.sunrise[0]')
else
  sunrise=$(printf "%s" "$json" | sed -n 's/.*"sunrise":\["\([^"]*\)".*/\1/p')
fi

# "2026-02-10T07:01" -> "07:01"
printf "%s\n" "${sunrise#*T}"

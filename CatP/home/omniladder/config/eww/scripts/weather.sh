#!/usr/bin/env bash
set -euo pipefail

# ------------------------
# Cache location (12h)
# ------------------------

cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/eww-weather-loc"
ttl_seconds=$((12 * 60 * 60))  # 12 hours
now=$(date +%s)

if [[ -f "$cache_file" ]]; then
  cache_time=$(stat -c %Y "$cache_file")
  age=$((now - cache_time))
else
  age=$((ttl_seconds + 1))
fi

if (( age < ttl_seconds )); then
  read -r lat lon < "$cache_file"
else
  loc=$(curl -fsS https://ipinfo.io/loc)
  lat=${loc%,*}
  lon=${loc#*,}

  mkdir -p "$(dirname "$cache_file")"
  printf "%s %s\n" "$lat" "$lon" > "$cache_file"
fi

# ------------------------
# Fetch weather
# ------------------------

json=$(curl -fsS "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,weather_code&temperature_unit=fahrenheit")

temp=$(echo "$json" | grep -oP '"temperature_2m":\s*\K[0-9.]+' || true)
code=$(echo "$json" | grep -oP '"weather_code":\s*\K[0-9]+' || true)

[[ -n "$temp" && -n "$code" ]] || {
  echo "Weather parse failed"
  exit 1
}

# ------------------------
# Weather description
# ------------------------

case "$code" in
  0) desc="Clear" ;;
  1|2) desc="Partly Cloudy" ;;
  3) desc="Cloudy" ;;
  45|48) desc="Fog" ;;
  51|53|55) desc="Drizzle" ;;
  56|57) desc="Freezing Drizzle" ;;
  61|63|65) desc="Rain" ;;
  66|67) desc="Freezing Rain" ;;
  71|73|75) desc="Snow" ;;
  77) desc="Snow Grains" ;;
  80|81|82) desc="Rain Showers" ;;
  85|86) desc="Snow Showers" ;;
  95) desc="Thunderstorm" ;;
  96|99) desc="Thunderstorm + Hail" ;;
  *) desc="Unknown" ;;
esac

echo "$desc ${temp}°F"

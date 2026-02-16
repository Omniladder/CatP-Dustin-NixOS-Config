#!/bin/sh
# Shutdown system
if command -v systemctl >/dev/null 2>&1; then
  systemctl poweroff
elif command -v poweroff >/dev/null 2>&1; then
  poweroff
fi


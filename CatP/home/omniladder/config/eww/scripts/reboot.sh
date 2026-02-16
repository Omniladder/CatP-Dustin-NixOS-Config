#!/bin/sh
# Reboot system
if command -v systemctl >/dev/null 2>&1; then
  systemctl reboot
elif command -v reboot >/dev/null 2>&1; then
  reboot
fi


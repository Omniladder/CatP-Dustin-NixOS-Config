#!/bin/sh
# Suspend system
if command -v systemctl >/dev/null 2>&1; then
  systemctl suspend
elif command -v loginctl >/dev/null 2>&1; then
  loginctl suspend
fi


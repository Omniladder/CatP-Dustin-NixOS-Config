#!/bin/sh
# Lock screen
if command -v loginctl >/dev/null 2>&1; then
  loginctl lock-session
elif command -v xlock >/dev/null 2>&1; then
  xlock
elif command -v i3lock >/dev/null 2>&1; then
  i3lock
fi


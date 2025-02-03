#!/bin/bash

swaymsg create_output HEADLESS-1
sleep 2

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <ps|ggbr>"
  exit 1
fi

# Get the first argument
case "$1" in
  ps)
    wayvnc --output=HEADLESS-1 --max-fps=60 192.168.100.19 5900 &
    ;;
  ggbr)
    wayvnc --output=HEADLESS-1 --max-fps=60 192.168.100.124 5900 &
    ;;
  *)
    echo "Invalid argument. Use 'ps' or 'ggbr'."
    exit 1
    ;;
esac

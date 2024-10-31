#!/usr/bin/env sh

DATE=$(date '+%Y-%m-%d')
FILENAME=$(printf "%s\nscreenshot\nquit\n" "$DATE" | dmenu)

if [ "$FILENAME" != "quit" ]; then
  grim -g "$(slurp)" "$FILENAME.png"
fi

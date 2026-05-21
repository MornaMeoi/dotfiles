#!/usr/bin/env bash
VAULT=~/Notes/cpp-notes  # путь к твоему vault

if pgrep -x wf-recorder; then
  pkill -INT wf-recorder
  sleep 1
  ffmpeg -i /tmp/clip.mp4 -vf "fps=10,scale=800:-1" "$VAULT/assets/$(date +%Y%m%d_%H%M%S).gif"
  rm /tmp/clip.mp4
  notify-send "GIF сохранена в vault"
else
  notify-send "Запись началась"
  wf-recorder -g "$(slurp)" -f /tmp/clip.mp4
fi
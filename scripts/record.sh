#!/usr/bin/env bash
if pgrep -x wf-recorder; then
  pkill -INT wf-recorder
  notify-send "Запись остановлена"
  sleep 1
  ffmpeg -i /tmp/clip.mp4 -vf "fps=10,scale=800:-1" ~/Pictures/$(date +%Y%m%d_%H%M%S).gif
  notify-send "GIF сохранена в ~/Pictures"
else
  notify-send "Запись началась"
  wf-recorder -g "$(slurp)" -f /tmp/clip.mp4
fi
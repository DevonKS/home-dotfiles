#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Turn of all displays but hdmi
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    xrandr --output $m --off
  done
fi

if type "xrandr"; then
  xrandr --output HDMI-0 --auto
  xrandr --dpi 96

  # Launch polybar
  MONITOR="HDMI-0" polybar -c ~/.i3/polybar/polybar-nord-minimal/config main &

  i3-msg "workspace 1, move workspace to output HDMI-0"
  i3-msg "workspace 1, focus"
fi

feh --bg-fill '/home/devon/.i3/wallpapers/NordWallpaperPack/daniel-leone-v7daTKlZzaw-unsplash.jpg'

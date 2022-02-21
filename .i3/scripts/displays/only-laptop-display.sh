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

xrandr --output eDP-1-1 --auto --dpi 96

# Launch polybar
MONITOR=eDP-1-1 polybar -c ~/.i3/polybar/polybar-nord-minimal/config --reload main &

feh --bg-fill '/home/devon/.i3/wallpapers/NordWallpaperPack/daniel-leone-v7daTKlZzaw-unsplash.jpg'

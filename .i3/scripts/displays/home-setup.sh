#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Turn of all displays
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    xrandr --output $m --off
  done
fi

if type "xrandr"; then
  xrandr --output "eDP-1-1" --auto --output "DP-2" --auto --right-of "eDP-1-1" --output "HDMI-1-1" --auto --primary --right-of "DP-2" 
  xrandr --dpi 96

  MONITOR="eDP-1-1" polybar -c ~/.i3/polybar/polybar-nord-minimal/config main &
  MONITOR="DP-2" polybar -c ~/.i3/polybar/polybar-nord-minimal/config main &
  MONITOR="HDMI-1-1" polybar -c ~/.i3/polybar/polybar-nord-minimal/config main &

  i3-msg "workspace 1, move workspace to output eDP-1-1"
  i3-msg "workspace 2, move workspace to output DP-2"
  i3-msg "workspace 3, move workspace to output HDMI-1-1"
  i3-msg "workspace 2, focus"
fi

feh --bg-fill '/home/devon/.i3/wallpapers/NordWallpaperPack/daniel-leone-v7daTKlZzaw-unsplash.jpg'

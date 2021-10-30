#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Turn on all displays
if type "xrandr"; then
  monitors=()
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    monitors+=( "$m" )
  done
  xrandr --output "${monitors[0]}" --auto --dpi 96
  MONITOR=${monitors[0]} polybar -c ~/.i3/polybar/polybar-nord-minimal/config --reload main &
  for m in ${!monitors[*]}; do
    if [ "$m" -ne 0 ] 
    then
      i=$(($m - 1))
      xrandr --output "${monitors[$m]}" --right-of "${monitors[$i]}" --auto --dpi 96
      # sleep 1s
      # Launch polybar
      MONITOR="${monitors[$m]}" polybar -c ~/.i3/polybar/polybar-nord-minimal/config --reload main &
    fi
  done

  feh --bg-fill '/home/devon/.i3/wallpapers/NordWallpaperPack/daniel-leone-v7daTKlZzaw-unsplash.jpg'
fi


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
  xrandr --output "${monitors[0]}" --auto
  MONITOR=${monitors[0]} polybar -c ~/.i3/polybar/polybar-nord/config --reload main &
  for m in ${!monitors[*]}; do
    if [ "$m" -ne 0 ] 
    then
      i=$(($m - 1))
      xrandr --output "${monitors[$m]}" --right-of "${monitors[$i]}"
      # Launch polybar
      MONITOR=${monitors[$m]} polybar -c ~/.i3/polybar/polybar-nord/config --reload main &
    fi
  done
fi

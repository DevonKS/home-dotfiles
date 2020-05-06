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

xrandr --output DP-0 --auto

# Launch polybar
MONITOR=DP-0 polybar -c ~/.i3/polybar/polybar-nord/config --reload main &

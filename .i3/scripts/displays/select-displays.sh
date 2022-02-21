#!/bin/bash

res=$(rofi -p '' -dmenu < ~/.i3/scripts/displays/display-commands)

if [ "$res" == "home" ]; then
    ~/.i3/scripts/displays/home-setup.sh
fi
if [ "$res" == "all" ]; then
    ~/.i3/scripts/displays/all-displays.sh
fi
if [ "$res" == "all but laptop" ]; then
    ~/.i3/scripts/displays/all-but-laptop-displays.sh
fi
if [ "$res" == "only hdmi" ]; then
    ~/.i3/scripts/displays/only-hdmi-display.sh
fi
if [ "$res" == "only laptop" ]; then
    ~/.i3/scripts/displays/only-laptop-display.sh
fi
if [ "$res" == "mirror all" ]; then
    ~/.i3/scripts/displays/mirror-all-displays.sh
fi
exit 0

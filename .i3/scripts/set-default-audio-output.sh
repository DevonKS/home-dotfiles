#!/bin/bash

pacmd set-default-sink $(pactl list sinks short | awk '{print $2}' | rofi -dmenu)

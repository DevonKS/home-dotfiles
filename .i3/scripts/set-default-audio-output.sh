#!/bin/bash

newSink=$(pactl list sinks short | awk '{print $2}' | rofi -dmenu)
pacmd set-default-sink $newSink

# Move all audio threads to new sink
inputs=$(pactl list short sink-inputs | cut -f 1)
for i in $inputs; do
    pacmd move-sink-input "$i" "$newSink"
done

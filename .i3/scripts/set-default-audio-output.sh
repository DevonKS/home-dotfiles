#!/bin/bash

# Maps human-readable names to PulseAudio sink names 
declare -A SINK_NAMES
SINK_NAMES["PC"]="alsa_output.pci-0000_00_1f.3.analog-stereo"
SINK_NAMES["HDMI"]="alsa_output.pci-0000_01_00.1.hdmi-stereo"
SINK_NAMES["HDMI-1"]="alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"
SINK_NAMES["USB-Audio"]="alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo"

newSinkNickname=$(echo -e "PC\nHDMI\nHDMI-1\nUSB-Audio" | rofi -dmenu -p "Audio Output:")
newSink=${SINK_NAMES["$newSinkNickname"]}
echo $newSink
pacmd set-default-sink "$newSink"

# Move all audio threads to new sink
inputs=$(pactl list short sink-inputs | cut -f 1)
for i in $inputs; do
    pacmd move-sink-input "$i" "$newSink"
done

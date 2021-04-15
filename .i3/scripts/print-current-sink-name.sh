#!/bin/bash

# Maps PulseAudio sink names to human-readable names
declare -A SINK_NICKNAMES
SINK_NICKNAMES["alsa_output.pci-0000_00_1f.3.analog-stereo"]="PC"
SINK_NICKNAMES["alsa_output.pci-0000_01_00.1.hdmi-stereo"]="HDMI"
SINK_NICKNAMES["alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"]="HDMI-1"
SINK_NICKNAMES["alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo"]="USB-Audio"

firstRun=0

# Listen for changes and immediately create new output for the bar.
# This is faster than having the script on an interval.
LANG=$LANGUAGE pactl subscribe 2>/dev/null | {
    while true; do
        {
            # If this is the first time just continue and print the current
            # state. Otherwise wait for events. This is to prevent the
            # module being empty until an event occurs.
            if [ $firstRun -eq 0 ]; then
                firstRun=1
            else
                read -r event || break
                # Avoid double events
                if ! echo "$event" | grep -e "on card" -e "on sink" -e "on server"; then
                    continue
                fi
            fi
        } &>/dev/null
        sinkName=$(pacmd info | grep "Default sink" | cut -d" " -f4)
        if [ -n "${SINK_NICKNAMES[$sinkName]}" ]; then
	    echo "${SINK_NICKNAMES[$sinkName]}"
        else
	    echo "Sink #$1"
        fi 
    done
}

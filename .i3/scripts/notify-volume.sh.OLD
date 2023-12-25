function get_volume {
  amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  iconSound="volume-up-solid-light"
  iconMuted="volume-mute-solid-light"
  if is_mute ; then
    dunstify -i $iconMuted -r 2593 -u normal "mute"
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq --separator="─" 0 "$((volume / 5))" | sed 's/[0-9]//g')
    blank_bar=$(seq --separator=" " 0 "$(((150 - volume) / 5))" | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i $iconSound -r 2593 -u normal "${bar}${blank_bar}${volume}%"
  fi
}

send_notification

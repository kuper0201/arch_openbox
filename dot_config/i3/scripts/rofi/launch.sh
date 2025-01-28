#!/bin/bash

menu="$1"

if [ "$menu" = "appmenu" ]; then
    rofi -show drun -theme clean
elif [ "$menu" = "powermenu" ]; then
    rofi -modi 'Powermenu:~/.config/i3/scripts/rofi/powermenu.sh' -show Powermenu -theme powermenu -location 3 -xoffset -30 -yoffset 100
elif [ "$menu" = "tabmenu" ]; then
    ~/.config/i3/scripts/rofi/tabmenu.sh
elif [ "$menu" = "scratchpad" ]; then
    rofi -show scratchpad -modi 'scratchpad:~/.config/i3/scripts/rofi/scratchpad.sh' -theme clean
fi

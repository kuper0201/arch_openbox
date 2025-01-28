#!/bin/bash

xdotool search --sync --syncsleep 50 --limit 1 --class Rofi keyup --delay 0 Tab key --delay 0 Tab keyup --delay 0 Super_L keydown --delay 0 Super_L&

rofi -show window -theme powermenu

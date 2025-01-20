#!/bin/bash
arg="$1"

device_path="/sys/class/backlight/acpi_video0"

current_brightness=$(cat $device_path/brightness)
max_brightness=$(cat $device_path/max_brightness)

new_brightness=$current_brightness
if [ $arg = "up" ]; then
  new_brightness=$((new_brightness + 5))
elif [ $arg = "down" ]; then
  new_brightness=$((new_brightness - 5))
else
  exit 1
fi

if [ $new_brightness -gt $max_brightness ]; then
  new_brightness=$max_brightness
elif [ $new_brightness -lt 5 ]; then
  new_brightness=5
fi

echo $new_brightness > $device_path/brightness

NOTIFY_ID_FILE="/tmp/brightness_notify_id"

# 이전 알림 ID 읽기
if [ -f "$NOTIFY_ID_FILE" ]; then
    notify_id=$(cat "$NOTIFY_ID_FILE")
else
    notify_id=0
fi

# 알림 전송 및 새 알림 ID 저장
new_notify_id=$(dunstify -u low -h int:value:$new_brightness -t 3000 --replace="$notify_id" "Brightness" "${new_brightness}%" -p)
echo "$new_notify_id" > "$NOTIFY_ID_FILE"

#!/bin/bash
arg="$1"

device_path="/sys/class/leds/smc::kbd_backlight"

current_brightness=$(cat "$device_path/brightness")
max_brightness=$(cat "$device_path/max_brightness")

# 5% 단위 계산
step=$((max_brightness / 20))
if [ $step -lt 1 ]; then
  step=1
fi

new_brightness=$current_brightness
if [ "$arg" = "up" ]; then
  new_brightness=$((new_brightness + step))
elif [ "$arg" = "down" ]; then
  new_brightness=$((new_brightness - step))
else
  exit 1
fi

# 범위 제한
if [ "$new_brightness" -gt "$max_brightness" ]; then
  new_brightness=$max_brightness
elif [ "$new_brightness" -lt 0 ]; then
  new_brightness=0
fi

echo "$new_brightness" > "$device_path/brightness"

NOTIFY_ID_FILE="/tmp/kbd_brightness_notify_id"

# 현재 밝기를 백분율로 변환
percent=$((new_brightness * 100 / max_brightness))

# 이전 알림 ID 읽기
if [ -f "$NOTIFY_ID_FILE" ]; then
    notify_id=$(cat "$NOTIFY_ID_FILE")
else
    notify_id=0
fi

# 알림 전송 및 새 알림 ID 저장
new_notify_id=$(dunstify -u low -h int:value:"$percent" -t 3000 --replace="$notify_id" "Keyboard Brightness" "${percent}%" -p)
echo "$new_notify_id" > "$NOTIFY_ID_FILE"

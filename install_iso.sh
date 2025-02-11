#!/bin/bash

# 테마 및 스크립트 설치
cp dot_gtkrc-2.0 /etc/skel/.gtkrc-2.0
cp dot_Xresources /etc/skel/.Xresources
cp -r dot_config /etc/skel/.config
cp -r dot_themes /etc/skel/.themes
cp -r wallpapers /usr/share/wallpapers
cp -r icon_svg /usr/share/icon_svg

TARGET_DIR="/usr/share/wallpapers"

# 디렉터리 권한 설정
chmod 755 "$TARGET_DIR"
chown root:root "$TARGET_DIR"

# 내부 파일 권한 설정
find "$TARGET_DIR" -type f -exec chmod 644 {} \;
find "$TARGET_DIR" -type f -exec chown root:root {} \;

# 환경 변수 설정
sed -i "$ s/$/\nQT_QPA_PLATFORMTHEME=qt5ct\nQT_STYLE_OVERRIDE=kvantum\nGTK_THEME=Materia-dark/" /etc/environment
sed -i "$ s/$/\nGTK_IM_MODULE=fcitx\nQT_IM_MODULE=fcitx\nXMODIFIERS=@im=fcitx/" /etc/environment

# lightdm 배경화면 설정
sed -i 's|^#background.*|background=/usr/share/wallpapers/wall_1.png|' /etc/lightdm/lightdm-gtk-greeter.conf
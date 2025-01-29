#!/bin/bash

# 임시 사용자 이름 및 홈 디렉터리 설정
TEMP_USER="tempuser"
TEMP_HOME="/home/$TEMP_USER"

# 임시 사용자 생성
useradd -m -s /bin/bash "$TEMP_USER"
echo "$TEMP_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 작업 디렉터리 설정
su - "$TEMP_USER" -c "mkdir -p $TEMP_HOME/scripts"

# 필요한 패키지 설치 (루트 권한 필요)
pacman -Syu --needed --noconfirm nano git base-devel jq network-manager-applet i3-gaps xorg-server xorg-xinit pcmanfm-gtk3 lxappearance alacritty xdotool kvantum kvantum-theme-materia materia-gtk-theme kvantum-qt5 qt5ct qt6ct libnotify

# GUI 로그인 관리자 설치 및 활성화
pacman -Syu --needed --noconfirm lightdm lightdm-gtk-greeter
systemctl enable lightdm

# yay 설치 및 설정
su - "$TEMP_USER" -c "git clone https://aur.archlinux.org/yay.git $TEMP_HOME/yay"
su - "$TEMP_USER" -c "cd $TEMP_HOME/yay && makepkg -si --noconfirm"

# AUR 패키지 설치
su - "$TEMP_USER" -c "yay -Syu --needed --noconfirm polybar rofi dunst compton feh ttf-hack-nerd ttf-nanum"

# 테마 및 스크립트 설치
cp dot_bashrc /etc/skel/.bashrc
cp dot_gtkrc-2.0 /etc/skel/.gtkrc-2.0
cp dot_xinitrc /etc/skel/.xinitrc
cp dot_Xresources /etc/skel/.Xresources
cp -r scripts /etc/skel/scripts
cp -r dot_config /etc/skel/.config
cp -r dot_themes /etc/skel/.themes
cp -r wallpapers /usr/share/wallpapers

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

# 입력기 설치
pacman -Syu --needed --noconfirm fcitx5 fcitx5-im fcitx5-hangul fcitx5-configtool fcitx5-qt fcitx5-gtk

# 임시 사용자 삭제 및 홈 디렉터리 정리
userdel -r "$TEMP_USER"
sed -i "/$TEMP_USER ALL=(ALL) NOPASSWD:ALL/d" /etc/sudoers

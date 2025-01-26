#!/bin/bash

# install something
pacman -Syu --needed --noconfirm nano git base-devel jq network-manager-applet i3-gaps xorg-server xorg-xinit pcmanfm-gtk3 lxappearance alacritty xdotool kvantum kvantum-theme-materia materia-gtk-theme kvantum-qt5 qt5ct qt6ct libnotify

# for gui greeter
pacman -Syu --needed --noconfirm lightdm lightdm-gtk-greeter
systemctl enable lightdm

# install packages from AUR
yay -Syu --needed --noconfirm polybar rofi dunst compton feh ttf-hack-nerd

# install keybinds and themes
mv dot_bashrc /etc/skel/.bashrc
mv dot_xinitrc /etc/skel/.xinitrc
mv dot_Xresources /etc/skel/.Xresources
mv scripts /etc/skel/scripts

mv dot_config /etc/.config
mv dot_themes /etc/.themes

sudo sed -i "$ s/$/\nQT_QPA_PLATFORMTHEME=qt5ct\nQT_STYLE_OVERRIDE=kvantum\nGTK_THEME=Materia-dark/" /etc/environment

./install_hangul.sh

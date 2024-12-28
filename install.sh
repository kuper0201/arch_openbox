#!/bin/bash

# https://yjwang.tistory.com/165

# install something
pacman -Syu --needed --noconfirm nano git base-devel i3-gaps xorg-server xorg-xinit pcmanfm-gtk3 greetd-tuigreet lxappearance alacritty xdotool

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf yay

# greeter setting
# nano /etc/greetd/config.toml => command = "tuigreet --cmd /bin/bash"

systemctl enable greetd

yay -Syu polybar rofi dunst compton feh ttf-hack-nerd --needed --noconfirm

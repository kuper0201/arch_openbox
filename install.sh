#!/bin/bash

# https://yjwang.tistory.com/165

# install something
pacman -Syu --needed --noconfirm nano git base-devel jq i3-gaps xorg-server xorg-xinit pcmanfm-gtk3 greetd-tuigreet lxappearance alacritty xdotool

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf yay

# greeter setting
# nano /etc/greetd/config.toml => command = "tuigreet --cmd /bin/bash"
sed -i 's|command = "agreety --cmd /bin/sh"|command = "tuigreet --cmd /bin/bash"|' /etc/greetd/config.toml

systemctl enable greetd

yay -Syu polybar rofi dunst compton feh ttf-hack-nerd --needed --noconfirm

# install keybinds and themes
mv dot_bashrc ~/.bashrc
mv dot_xinitrc ~/.xinitrc
mv dot_Xresources ~/.Xresources
mv scripts ~/scripts

mv dot_config ~/.config
mv .themes ~/.themes

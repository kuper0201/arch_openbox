#!/bin/bash

# check root and exit
if [ "$EUID" -eq 0 ]; then
    echo "Do not run this script as root!"
    echo "Exiting..."
    exit 1
fi

# install something
sudo pacman -Syu --needed --noconfirm nano git base-devel jq i3-gaps xorg-server xorg-xinit pcmanfm-gtk3 lxappearance alacritty xdotool kvantum kvantum-theme-materia materia-gtk-theme kvantum-qt5 qt5ct qt6ct

# for tui greeter
sudo pacman -Syu --needed --noconfirm greetd-tuigreet
sudo sed -i 's|command = "agreety --cmd /bin/sh"|command = "tuigreet --cmd /bin/bash"|' /etc/greetd/config.toml
sudo systemctl enable greetd

# for gui greeter
#sudo pacman -Syu --needed --noconfirm lightdm lightdm-gtk-greeter
#sudo systemctl enable lightdm

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
sudo makepkg -si
cd ..
rm -rf yay

# install packages from AUR
yay -Syu polybar rofi dunst compton feh ttf-hack-nerd --needed --noconfirm

# install keybinds and themes
mv dot_bashrc ~/.bashrc
mv dot_xinitrc ~/.xinitrc
mv dot_Xresources ~/.Xresources
mv scripts ~/scripts

mv dot_config ~/.config
mv dot_themes ~/.themes

sudo echo "QT_QPA_PLATFORMTHEME=qt5ct\nQT_STYLE_OVERRIDE=kvantum" > /etc/environment

# set gtk3 theme
# lxappearance

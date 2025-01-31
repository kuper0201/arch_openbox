#!/bin/bash

# check root and exit
if [ "$EUID" -eq 0 ]; then
    echo "Do not run this script as root!"
    echo "Exiting..."
    exit 1
fi

# install something
sudo pacman -Syu --needed --noconfirm nano git base-devel jq network-manager-applet i3-gaps xorg-server xorg-xinit pcmanfm-gtk3 lxappearance alacritty xdotool kvantum kvantum-theme-materia materia-gtk-theme kvantum-qt5 qt5ct qt6ct libnotify

# for tui greeter
#sudo pacman -Syu --needed --noconfirm greetd-tuigreet
#sudo sed -i 's|command = "agreety --cmd /bin/sh"|command = "tuigreet --cmd /bin/bash"|' /etc/greetd/config.toml
#sudo systemctl enable greetd

# for gui greeter
sudo pacman -Syu --needed --noconfirm lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# install packages from AUR
yay -Syu --needed --noconfirm polybar rofi dunst compton feh

# backup
mv ~/.bashrc ~/.bashrc_bak
mv ~/.gtkrc-2.0 ~/.gtkrc-2.0_bak
mv ~/.xinitrc ~/.xinitrc_bak
mv ~/.Xresources ~/.Xresources_bak
mv ~/scripts ~/scripts_bak
mv /usr/share/wallpapers ~/wallpapers_bak

mv ~/.config ~/.config_bak
mv ~/.themes ~/.themes_bak

# install keybinds and themes
mv dot_bashrc ~/.bashrc
mv dot_gtkrc-2.0 ~/.gtkrc-2.0
mv dot_xinitrc ~/.xinitrc
mv dot_Xresources ~/.Xresources
mv scripts ~/scripts

mv dot_config ~/.config
mv dot_themes ~/.themes

mkdir -p ~/.local/share
mv fonts ~/.local/share/fonts

sudo mv wallpapers /usr/share/wallpapers
TARGET_DIR="/usr/share/wallpapers"

# 디렉터리 권한 설정
sudo chmod 755 "$TARGET_DIR"
sudo chown root:root "$TARGET_DIR"

# 내부 파일 권한 설정
sudo find "$TARGET_DIR" -type f -exec chmod 644 {} \;
sudo find "$TARGET_DIR" -type f -exec chown root:root {} \;

sudo sed -i "$ s/$/\nQT_QPA_PLATFORMTHEME=qt5ct\nQT_STYLE_OVERRIDE=kvantum\nGTK_THEME=Materia-dark/" /etc/environment

# for nm-applet
sudo systemctl enable NetworkManager

read -p "install hangul? [Y/n]: " response

response=${response:-y}

if [[ "${response,,}" == "y" ]]; then
    echo "Installing hangul..."
    ./install_hangul.sh
else
    echo "Skipping hangul installation."
fi

read -p "install rvnc? [Y/n]: " response

response=${response:-y}

if [[ "${response,,}" == "y" ]]; then
    echo "Installing rvnc..."
    ./install_rvnc.sh
else
    echo "Skipping rvnc installation."
fi

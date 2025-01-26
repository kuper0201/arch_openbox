#!/bin/bash

sudo pacman -Syu --needed --noconfirm fcitx5 fcitx5-im fcitx5-hangul fcitx5-configtool fcitx5-qt fcitx5-gtk

sudo sed -i "$ s/$/\nGTK_IM_MODULE=fcitx\nQT_IM_MODULE=fcitx\nXMODIFIERS=@im=fcitx/" /etc/environment

yay -Syu --noconfirm ttf-nanum

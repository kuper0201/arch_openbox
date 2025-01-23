#!/bin/bash

sudo pacman -Syu --needed --noconfirm xterm
yay -Syu --needed --noconfirm realvnc-vnc-server

sudo systemctl enable vncserver-x11-serviced
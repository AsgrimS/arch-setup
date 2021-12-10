#!/bin/bash

sudo timedatectl set-ntp true
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

paru -S gnome gnome-tweaks # Gnome DE
paru -S ttf-fira-code ttf-ubuntu-font-family noto-fonts-emoji matcha-gtk-theme xcursor-breeze # Optional theme/fonts packages
paru -S zramd

sudo systemctl enable gdm # For gnome
sudo systemctl enable zramd.service

printf "\e[1;32mDone! reboot.\e[0m"

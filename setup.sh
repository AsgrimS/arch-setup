#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc
echo "LANG=en_US.UTF-8" >> /etc/locale.gen
echo "LANG=pl_PL.UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pl_PL.UTF-8" >> /etc/locale.conf
echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=pl_PL" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname # CHANGE
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd # CHANGE AFTER

pacman -S linux linux-lts linux-firmware linux-headers linux-lts-headers btrfs-progs intel-ucode base-devel sof-firmware alsa-ucm-conf openssh networkmanager dialog wirelesstools netctl cups avahi grub dosfstools reflector  os-prober mtools efibootmgr bluez bluez-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack git nano
pacman -S tlp # You can remove the tlp package if you are installing on a desktop or vm
pacman -S gnome gnome-tweaks # Gnome DE
pacman -S ttf-fira-code ttf-ubuntu-font-family noto-fonts-emoji matcha-gtk-theme xcursor-breeze # Optional theme/fonts packages

# pacman -S xf86-video-amdgpu
pacman -S nvidia nvidia-lts nvidia-settings # Drivers for nvidia

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth.service
systemctl enable cups.service
systemctl enable sshd
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer # For ssds
systemctl enable gdm # For gnome

reflector --sort rate -l 30 --save /etc/pacman.d/mirrorlist
timedatectl set-ntp true

useradd -m username # CHANGE
echo ermanno:password | chpasswd # CHANGE AFTER and enable wheel

printf "\e[1;32mDone! Complete setup, type exit, umount -a and reboot.\e[0m"


#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime # CHANGE
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo "LANG=pl_PL.UTF-8" >> /etc/locale.conf
echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=pl_PL" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname # CHANGE
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

pacman -S --needed linux linux-lts linux-firmware linux-headers linux-lts-headers btrfs-progs intel-ucode base-devel sof-firmware alsa-ucm-conf openssh networkmanager dialog wireless_tools grub dosfstools rsync reflector os-prober mtools efibootmgr bluez bluez-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack avahi cups system-config-printer man-db
pacman -S tlp # You can remove the tlp package if you are installing on a desktop or vm

# pacman -S xf86-video-amdgpu # Drivers for AMD
pacman -S nvidia nvidia-lts nvidia-settings # Proprietary drivers for Nvidia

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth.service
systemctl enable cups.service
systemctl enable avahi-daemon
systemctl enable sshd
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer # For ssds

useradd -m -g users -G wheel <username> # CHANGE

printf "\e[1;32mDone! Follow readme to complete the setup.\e[0m"


# arch-setup-script

## After bootign into usb
1. Prepare, format and mount partitions and subvolumes
2. `pacstrap /mnt base` to install arch
3. `genfstab -U /mnt >> /mnt/etc/fstab` to generate fstab
4. arch-chroot /mnt

## In chroot
1. Install git with `pacman -S git`
2. Copy this repo with `git clone https://github.com/AsgrimS/arch-setup-script.git`
3. Open `setup.sh` file and adjust fileds.
4. Make `setup.sh` executable
5. Run `setup.sh`
6. `passwd` and `passwd <user>` to change passowrd of the root and user
7. `visudo` `EDITOR=nano visudo` and uncomment `%wheel ALL=(ALL) ALL`
8. Edit `mkinitcpio.conf`
9. Run `mkinitcpio -p linux` and `mkinitcpio -p linux-lts` 
10. Adjust grub
11. Exit -> `umount -a` -> reboot

## Post installation tweaks
1. Install `paru` - aur helper.
2. Make `post-installation-tweaks.sh` executable
3. Run `post-installation-tweaks.sh`
4. In `/etc/default/zramd` set swap size.
5. Setup snapepr (https://wiki.archlinux.org/title/snapper)
5. Reboot

# Final setup
Arch on BTRFS and GNOME ready for snapper configuration.
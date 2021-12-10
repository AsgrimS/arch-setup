# arch-setup-script

## After bootign into usb
1. prepare, format and mount partitions and subvolumes
2. `pacstrap /mnt base` to install arch
3. `genfstab -U /mnt >> /mnt/etc/fstab` to generate fstab
4. arch-chroot /mnt

## In chroot
1. isntall git with `pacman -S git`
2. copy this repo with `git clone https://github.com/AsgrimS/arch-setup-script.git`
3. open `setup.sh` file and adjust fileds.
4. make `setup.sh` executable
5. run `setup.sh`
6. `passwd` and `passwd <user>` to change passowrd of the root and user
7. `visudo` `EDITOR=nano visudo` and uncomment `%wheel ALL=(ALL) ALL`
8. Edit `mkinitcpio.conf`
9. Run `mkinitcpio -p linux` and `mkinitcpio -p linux-lts` 
10. Adjust grub
11. Exit -> `umount -a` -> reboot

## Post installation tweaks
1. Install `paru` - aur helper.
2. make `post-installation-tweaks.sh` executable
3. run `post-installation-tweaks.sh`

# Final setup
Arch on BTRFS and GNOME ready for snapper configuration.
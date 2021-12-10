# arch-setup
## After bootign into usb
1. Prepare, format and mount partitions and subvolumes
2. `pacstrap /mnt base git nano` to install arch (you may want to install vim instead of nano)
3. `genfstab -U /mnt >> /mnt/etc/fstab` to generate fstab
4. Enter your arch installation with`arch-chroot /mnt`

## In chroot
1. Copy this repo with `git clone https://github.com/AsgrimS/arch-setup.git`
2. Open `setup.sh` file and adjust fileds.
3. Make `setup.sh` executable
4. Run `setup.sh`
5. `passwd` and `passwd <user>` to change passowrd of the root and user
6. `visudo` `EDITOR=nano visudo` and uncomment `%wheel ALL=(ALL) ALL`
7. Edit `etc/mkinitcpio.conf`
    - add `btrfs` to the `MODULES=()`
    - add `encrypt` to the `HOOKS=(...block -> encrypt <- filesystems ...)`
8. Run `mkinitcpio -p linux` and `mkinitcpio -p linux-lts` 
9. Edit `/etc/default/grub`
    - uncommenct `GRUB_ENABLE_CRYPTODISK=y`
    - add to the `GRUB_CMDLINE_DEFAULT="... quite cryptdevice=[path to your encryptet partition]:cryptroot:allow-discards root=/dev/mapper/cryptroot`
10. Regenerate grub config with `grub-mkconfig -o /boot/grub/grub.cfg`
10. Exit -> `umount -a` -> reboot

## Post installation tweaks
0. If on wifi scan avaible sources with `nmcli device wifi list` and connect with `nmcli device wifi connect SSID_or_BSSID password password`
1. Install `paru` - aur helper.
2. Make `post-installation-tweaks.sh` executable
3. Run `post-installation-tweaks.sh`
4. In `/etc/default/zramd` set swap size.
5. Setup snapper (https://wiki.archlinux.org/title/snapper)
5. Reboot

## Partitioning and formatting
1. Create 300M EFI system partition
2. With the rest create standard Linux filesystem (leave some space for ssd health)
3. Encrypt with `cryptsetup luksFormat dev/.. <- path to the linux filesystem partition`
4. Open encrypted partition with `cryptsetup luksOpen dev/.. cryptroot`
5. Format boot partition with `mkfs.vfat /dev/.. <- path to boot partition`
6. Format linuks partition with `mkfs.btrfs /dev/mapper/cryptroot`
7. Mount /mnt with `mount /dev/mapper/cryptroot /mnt`
8. Enter /mnt with `cd /mnt` and create root subvolumes `btrfs su cr @`, `btrfs su cr @home`, `btrfs su cr @var`, `btrfs su cr @snapshots`
9. Go back with `cd` and unmount /mnt with `umount /mnt`
10. Mount root subvolume with `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt`
11. Create directories for the rest of subvolumes with `mkdir mnt/{boot,home,var,.snapshots}`
12. Mount boot partition with `mount /dev/.. <- path to boot partition /mnt/boot`
13. Mount subvolumes with:
    - `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/home`
    - `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/var`
    - `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/mapper/cryptroot /mnt/.snapshots`

# Final setup
Arch on BTRFS and GNOME ready for snapper configuration.

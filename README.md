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
5. Setup snapper (https://wiki.archlinux.org/title/snapper)
5. Reboot

## Partitioning and formatting
1. Create 300M EFI system partition
2. With the rest create standard Linux filesystem (leave some space for ssd health)
3. Encrypt with `cryptsetup luksFormat [dev/.. <- path to the linux filesystem partition].
4. Open encrypted partition with `cryptsetup luksOpen <dev/...> cryptroot`
5. Format boot partition with `mkfs.vfat /dev/.. <- path to boot partition`
6. Format linuks partition with `mkfs.btrfs /dev/mapper/cryptroot`
7. Mount /mnt with `mount /dev/mapper/cryptroot /mnt`
8. Enter /mnt with `cd /mnt` and create root subvolumes `btrfs su cr @`, `btrfs su cr @home`, `btrfs su cr @var`, `btrfs su cr @snapshots`
9. Go back with `cd` and unmount /mnt with `umount /mnt`
10. Mount root subvolume with `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt`
11. Create directories for the rest of subvolumes with `mkdir mnt/{home,var,.snapshots}`
12. Mount subvolumes with:
 - `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/home`
 - `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/var`
 - `mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/mapper/cryptroot /mnt/.snapshots`

# Final setup
Arch on BTRFS and GNOME ready for snapper configuration.

# /etc/vconsole.conf
```
FONT=Lat2-Terminus16
KEYMAP=fr-bepo
```

# Partionning

```
gdisk /dev/sda

o # create new gpt partition table
n # create new partition
# choose 550M for the size
# type 0xEF00 = efi system partition

# /boot has type 0x8300 (linux fs)
# / has type 0x8E00 (linux lvm)
```

# LUKS setup (unencrypted /boot)
Check that correct kernel modules are loaded: `lsmod | grep dm_crypt` and `lsmod | grep dm_mod`.

```
# /dev/sda3 is the lvm partition
cryptsetup luksFormat -v -s 512 -h sha512 /dev/sda3
cryptsetup open /dev/sda3 luks_lvm
```

# configure LVM

```
pvcreate /dev/mapper/luks_lvm
vgcreate arch /dev/mapper/luks_lvm
lvcreate -n swap -L 1G -C y arch
lvcreate -n root --extents 100%FREE arch
```

# Format

```
mkfs.fat -F32 /dev/sda1 # efi partition
mkfs.ext4 -L boot /dev/sda2 # boot partition
mkswap /dev/mapper/arch-swap
mkfs.ext4 -L root /dev/mapper/arch-root
```

# Mount partitions

```
swapon /dev/mapper/arch-swap
swapon -a ; swapon -s
mount /dev/mapper/arch-root /mnt
mkdir -p /mnt/boot
mount /dev/sda2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

# Install arch linux

Set `/etc/pacman.d/mirrorlist` correctly (closest mirrors on top) before proceeding.

```
pacstrap /mnt base base-devel efibootmgr vim wpa_supplicant dialog xterm grub
genfstab -U /mnt >> /mnt/etc/fstab
```

Then `arch-chroot /mnt /bin/bash` and follow the user guide until next step.


# Initramfs

Configure mkinitcpio for luks (https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration#mkinitcpio). Add `keyboard sd-vconsole sd-encrypt lvm2` to the `HOOKS` line in `/etc/mkinitcpio.conf`. `keyboard` should already be there. Also replace `udev` with `systemd`.

# Grub

Add to `/etc/default/grub`
`GRUB_CMDLINE_LINUX_DEFAULT="quiet rd.luks.name=<DEVICE_UUID>=cryptlvm root=/dev/arch/root"`

To get the device uuid: `ls -al /dev/disk/by-uuid/`. The `DEVICE_UUID` is for the luks partition (/dev/sda3 here). `arch` in `root=/dev/arch/root` refers to the volume group used by lvm.


# Auto unlock luks encrypted partition (optional)


```
dd if=/dev/urandom of=/arch_luks_key.bin  bs=512 count=10
chmod 000 /arch_luks_key.bin
chmod 600 /boot/initramfs-linux*
cryptsetup luksAddKey /dev/sda3 /arch_luks_key.bin
```

And add that to `/etc/mkinitcpio.conf`: `FILES=/arch_luks_key.bin`.

# Generate configs

```
mkinitcpio -p linux
grub-install --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
```

# Cleanly reboot

Exit the chroot, unmount everything `umount -R /mnt` and `reboot`.


# Install some softs

`pacman -S zsh git tree neovim python-neovim htop fzf ripgrep termite`


# Create user

groupadd sudo
useradd -m --groups sudo -s /bin/zsh greg


# Misc stuff in userland

## Keep wifi enabled
`netctl list` and `netctl enable <profile-name>`


## GUI
Once gpu driver and xorg are installed:

```
pacman -S i3-wm rofi
```

Get [i3status-rust](https://github.com/greshake/i3status-rust) and install/compile it.

For desktop display config:


```
#!/usr/bin/env bash

if $(xrandr --query | grep "HDMI-0 connected" 2>&1 > /dev/null)
then
  xrandr \
    --output VGA-0 --off \
    --output DVI-I-0 --off \
    --output HDMI-0 --auto --left-of DVI-I-1 \
    --output DVI-I-1 --primary --auto --rotate normal
else
  xrandr \
    --output VGA-0 --off \
    --output DVI-I-0 --off \
    --output HDMI-0 --off \
    --output DVI-1-1 --primary --auto --rotate normal
fi
```

# Resources

* https://computingforgeeks.com/install-arch-linux-luks-encryption/

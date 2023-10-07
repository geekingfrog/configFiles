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
pacstrap /mnt base base-devel linux linux-firmware grub efibootmgr vim networkmanager
genfstab -U /mnt >> /mnt/etc/fstab
```

Then `arch-chroot /mnt /bin/bash` and follow the user guide until next step.


# Initramfs

Configure mkinitcpio for luks (https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration#mkinitcpio). Add `keyboard sd-vconsole sd-encrypt lvm2` to the `HOOKS` line in `/etc/mkinitcpio.conf`. `keyboard` should already be there. Also replace `udev` with `systemd`.

# Grub
**DEPRECATED** now I use systemd-boot

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

# sudo setup

See [this topic](https://bbs.archlinux.org/viewtopic.php?id=257281), need to add the following two things:

`/etc/pam.d/nss-auth`
```
#%PAM-1.0
session sufficient pam_unix.so
session sufficient pam_systemd_home.so
session required pam_deny.so
```

And add the following line (toward the end) in `/etc/pam.d/system-auth`
```
session    required                    pam_limits.so
session    substack                    nss-auth # <- THAT LINE!!!
session    required                    pam_unix.so
session    optional                    pam_permit.so
```


# Install some softs

`pacman -S zsh git tree neovim python-neovim htop fzf ripgrep alacritty fd hyperfine hexyl tokei`
and some fonts:

`pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-font-awesome ttf-inconsolata ttf-roboto`


# Create user

groupadd sudo
useradd -m --groups sudo -s /bin/zsh greg


# Misc stuff in userland

## Keep wifi enabled
`netctl list` and `netctl enable <profile-name>`


## GUI
Once gpu driver and xorg are installed:

```
pacman -S i3-wm rofi i3status-rust
```


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

## Keyboard in xorg


To put under `/etc/X11/xorg.conf.d/10-keyboard.conf`.
```
Section "InputClass"
	Identifier "system-keyboard"
	MatchIsKeyboard "on"
	Option "XkbLayout" "fr,us"
	Option "XkbVariant" "bepo,"

	# the list of options is in /usr/share/X11/xkb/rules/base.lst
	Option "XkbOptions" "grp:alt_caps_toggle"
EndSection
```

## SSH agent

See [SO](https://stackoverflow.com/a/38980986)

In `~/.config/systemd/user/ssh-agent.service`
```
[Unit]
Description=SSH key agent

[Service]
Type=forking
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

In `~/.pam_environment`: `SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"`. Then `systemctl --user enable ssh-agent`, `systemctl --user start ssh-agent`.
And in `~/.ssh/config`, add the line `AddKeysToAgent yes`.


## Chinese input method
See [IBus](https://wiki.archlinux.org/index.php/IBus). `sudo pacman -S ibus ibus-libpinyin`.

```
# in ~/.pam_environment

GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
```

Add `ibus-daemon -drx` to `~/.xinitrc`.

## Other softs
For things not packaged yet, or in aur.
* [aura](https://aur.archlinux.org/packages/aura-bin/) from aur to install stuff from aur
* [bottom](https://github.com/ClementTsang/bottom) `sudo aura -A bottom-bin` a fancy `htop`
* [ripgrep-all](https://github.com/phiresky/ripgrep-all) `cargo install --path .` a wrapper around ripgrep to search in anything.
* [procs](https://github.com/dalance/procs) `cargo install procs` a fancy `ps`
* [zoxide](https://github.com/ajeetdsouza/zoxide) smart cd command.
* [bat](https://github.com/sharkdp/bat) a cat clone with wings.

# Resources

* https://computingforgeeks.com/install-arch-linux-luks-encryption/

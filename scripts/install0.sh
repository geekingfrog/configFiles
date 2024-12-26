#!/usr/bin/env bash
set -euo pipefail

function copy_self() {
  cp "${PWD}/$0" "/mnt/install0.sh"
  chmod +x "/mnt/install0.sh"
  sed -i 's/^main$/main_chroot/' /mnt/install0.sh
}

function main() {
  # To be run once filesystem is formatted and mounted under /mnt
  # This is more or less the step 2 of
  # https://wiki.archlinux.org/title/Installation_guide

  mirror='https://archlinux.org/mirrorlist/?country=GB&protocol=https&ip_version=4'
  curl -sl "$mirror" > /etc/pacman.d/mirrorlist
  sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist
  pacman -Sy
  pacman -S gum --noconfirm --needed

  format

  pacstrap -K /mnt base base-devel linux linux-firmware vi vim neovim iwd curl git zsh sudo man gum sed unzip jdk-openjdk rlwrap clojure
  genfstab -U /mnt > /mnt/etc/fstab

  # This cannot be done within the chroot
  # https://wiki.archlinux.org/title/Systemd-resolved
  ln -sf ../run/systemd/resolve/stub-resolv.conf /mnt/etc/resolv.conf

  copy_self

  log "chroot ready, 'arch-chroot /mnt' and then run the same script again to continue"
}

function log() {
  if [ -z ${2+x} ];
  then
    level="info"
    message="$1"
  else
    level="$1"
    message="$2"
  fi
  gum log --level "$level" --time rfc3339 "$message"
}

function setup_user() {
  username="$(gum input --placeholder 'user name')"
  username="${username:=greg}"
  groupadd --force sudo

  if id "$username" >/dev/null 2>&1; then
    log "user $username already setup, skip"
  else
    log "setting up user: $username"
    useradd -s /usr/bin/zsh "$username" -m -G sudo
    passwd "$username"
  fi


  if grep -Eq '^%sudo ALL' /etc/sudoers;
  then
    log "sudoers is good"
  else
    log "setting up sudoers file"
    echo '%sudo ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
  fi

  touch "/home/${username}/.zshrc"
  chown "${username}:${username}" "/home/${username}/.zshrc"

  setup_aur "$username"

  sudo -u "$username" yay -S babashka-bin --answerclean All --answerdiff None --answeredit None
  sudo -u "$username" git clone https://github.com/geekingfrog/configFiles.git "/home/${username}/configFiles"
}

function setup_bootloader() {
  log "bootloader setup"
  bootctl install

  set +e
  # silence ls|grep warning, which here is fine
  # shellcheck disable=SC2010
  ls "/dev/mapper" | grep -q root
  is_encrypted=$?
  set -e

  if [ "$is_encrypted" = 0 ];
  then
    log "Boot setup for encryption"
    hooks="HOOKS=(base systemd autodetect microcode modconf kms keyboard block sd-encrypt filesystems fsck)"
    disk_uuid="$(blkid | grep TYPE=\"crypto_LUKS\" | grep -o ' UUID="[^"]*"' | sed 's/ UUID="\([^"]*\)"/\1/')"

    boot_options="rd.luks.name=${disk_uuid}=root root=/dev/mapper/root"
  else
    hooks="HOOKS=(base systemd autodetect microcode modconf kms keyboard block filesystems fsck)"

    log "choose the disk of root partition"
    disk_uuid="$(blkid | gum choose --height 8 | grep -o ' UUID="[^"]*"' | sed 's/UUID="\([^"]*\)"/\1/')"

    boot_options="root=UUID=$disk_uuid"
  fi

  sed -i "s/^HOOKS=(.*/$hooks/" /etc/mkinitcpio.conf
  mkinitcpio -P

  cat > /boot/loader/loader.conf <<EOF
default  arch.conf
timeout  2
console-mode max
editor   no
EOF

  mkdir -p /boot/loader/entries/


  cat > /boot/loader/entries/arch.conf <<EOF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options $boot_options rw
EOF
}

function setup_chroot_machine() {
  # Rest of the install guide to be run within a chroot

  log "setting up timezone assuming Europe/London"
  ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

  # when running in a VM, this may fail, so just let the error messages
  # and carry on
  set +e
  hwclock --systohc
  set -e

  log "generating locales"
  cat > /etc/locale.gen << EOF
en_GB.UTF-8 UTF-8
fr_FR.UTF-8 UTF-8
zh_TW.UTF-8 UTF-8
EOF
  locale-gen
  echo "LANG=en_GB.UTF.8" > /etc/locale.conf

  hostname="$(gum input --placeholder 'hostname [autoarch]')"
  hostname="${hostname:-autoarch}"
  echo "hostname" > /etc/hostname

  log "root password:"
  passwd

  setup_bootloader
}

function setup_network() {
  # Very basic network setup for systemd-networkd

  cat > /etc/systemd/network/20-wired.network << EOF
[Match]
Name=enp*

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
EOF

  cat > /etc/systemd/network/25-wireless.network << EOF
[Match]
Name=wl*

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
IgnoreCarrierLoss=3s
EOF

  systemctl start systemd-networkd.service
  systemctl enable systemd-networkd.service

  systemctl start systemd-resolved.service
  systemctl enable systemd-resolved.service
}

function setup_aur() {
  username="${1:-greg}"
  log "setting up aur for username $username"
  aur_dir="/home/${username}/aur/"
  mkdir -p "$aur_dir"
  chown "${username}:${username}" "$aur_dir"
  if which yay > /dev/null 2>&1; then
    log "yay already there, skipping"
    return
  fi

  log "installing yay-bin"
  pushd "$aur_dir"
  sudo -u greg git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  sudo -u greg makepkg -si
  popd
}

function main_chroot() {
  # This is the second part of the script, designed to be run in the chroot
  setup_chroot_machine
  setup_network
  setup_user

  log "All done!"
  echo "exit now the chroot, and umount everything before rebooting into the OS"
  echo "umount /mnt/boot"
  echo "umount /mnt"
  echo "cryptsetup close root"
  echo "systemctl reboot"
}

function format() {
  log "PARTITIONNING"

  set +e
  gum confirm "Automatic partitionning?"
  res=$?
  set -e

  if [ $res -ne 0 ];
  then
    log "aborting partioning"
    return
  fi

  line="$(lsblk --filter 'TYPE=="disk"' | gum choose --header 'Choose the disk:')"
  disk="$(echo "$line" | cut -d' ' -f 1)"
  echo "partitionning disk $disk"
  # line="$(blkid | gum choose --height 8)"

  # see: https://stackoverflow.com/questions/2953081/how-can-i-write-a-heredoc-to-a-file-in-bash-script
  # this creates 2 partitions: a 2GB EFI partition, followed by a linux partition for the rest of the disk
  cat > /tmp/partition.sfdisk <<EOF
label: gpt
device: /dev/sda
unit: sectors
sector-size: 512

/dev/sda1 : start= 2048, size=2G, type=U
/dev/sda2 : type=L
EOF

  sed -i "s|/dev/sda/|/dev/$disk|" /tmp/partition.sfdisk

  cat /tmp/partition.sfdisk
  set +e
  gum confirm "going to format /dev/$disk using that script"
  res=$?
  set -e

  if [ $res -ne 0 ];
  then
    log "error" "ABORT"
    return
  fi

  sfdisk "/dev/$disk" < /tmp/partition.sfdisk

  boot_part="/dev/${disk}1"
  mkfs.fat -F 32 "$boot_part"

  root_part="/dev/${disk}2"

  set +e
  gum confirm "set up LUKS on ${root_part}?"
  res=$?
  set -e

  if [ "$res" = 0 ];
  then
    cryptsetup -v luksFormat "$root_part"
    cryptsetup open "$root_part" root
    root_part="/dev/mapper/root"
  fi

  log "root partition is $root_part"

  mkfs.ext4 "$root_part"

  mount "$root_part" /mnt
  mount --mkdir "$boot_part" /mnt/boot

}

main

#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

########################################
# Keyboard
########################################
# for more info, man xkeyboard-config
exec --no-startup-id setxkbmap \
  -layout "fr,gb" \
  -variant "bepo," \
  -option "" \
  -option "terminate:ctrl_alt_bksp" \
  -option "grp:lctrl_lwin_toggle" \
  -option "compose:caps"


# increase mouse acceleration
# https://wiki.archlinux.org/index.php/Mouse_acceleration
xset m 6/1 0

ibus-daemon -drx

# screen configuration
xrandr --output DVI-I-1 --primary --auto --output HDMI-0 --auto --left-of DVI-I-1

exec i3

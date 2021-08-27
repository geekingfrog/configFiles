#!/usr/bin/env bash

if $(xrandr --query | grep "HDMI-0 connected" 2>&1 > /dev/null)
then
  xrandr \
    --output VGA-0 --off \
    --output DVI-I-0 --off \
    --output DVI-I-1 --auto --rotate normal \
    --output HDMI-0 --primary --auto --left-of DVI-I-1
else
  xrandr \
    --output VGA-0 --off \
    --output DVI-I-0 --off \
    --output HDMI-0 --off \
    --output DVI-1-1 --primary --auto --rotate normal
fi

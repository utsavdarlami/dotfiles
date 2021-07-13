#!/bin/sh
xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output HDMI1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output DP5 --off
cp ~/.config/bspwm/nvidia_single_rc ~/.config/bspwm/bspwmrc
bspc wm -r

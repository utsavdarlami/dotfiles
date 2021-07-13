#!/bin/sh
xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x900 --rotate normal --output DP1 --mode 1440x900 --pos 320x0 --rotate normal --output HDMI1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output DP5 --off
cp ~/.config/bspwm/nvidia_double_rc ~/.config/bspwm/bspwmrc
bspc wm -r

#!/bin/sh
xrandr --output eDP1 --primary --mode 1920x1080 --pos 1440x0 --rotate normal --output DP1 --mode 1440x900 --pos 0x0 --rotate normal --output DP2 --off --output DP3 --off --output DP4 --off --output DP5 --off --output HDMI1 --off --output VIRTUAL1 --off
cp ~/.config/bspwm/nvidia_double_rc ~/.config/bspwm/bspwmrc
bspc wm -r

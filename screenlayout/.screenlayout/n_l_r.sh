#!/bin/sh
xrandr --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-1 --mode 1440x900 --pos 1920x0 --rotate normal --output HDMI-1-1 --off --output DP-1-2 --off --output DP-1-3 --off --output DP-1-4 --off --output DP-1-5 --off
cp ~/.config/bspwm/nvidia_double_rc ~/.config/bspwm/bspwmrc
bspc wm -r

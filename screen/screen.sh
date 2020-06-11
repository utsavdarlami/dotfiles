#!/bin/sh
# Script to take screenshot from scrot
scrot -u 'ss-%Y-%m-%s-%d-%H_%M.png' && mv $HOME/*.png $HOME/Pictures/ScreenShot/ 

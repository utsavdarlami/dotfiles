#!/bin/bash
ICON=$HOME/.xlock/icon.png
# TMPBG=/tmp/screen.png
TMPBG=~/Desktop/pralab/try/tnx1wfvi1t131.jpg
# scrot /tmp/screen.png
# convert $TMPBG  $TMPBG
# 1366x768
convert -scale 1540x768 $TMPBG .lockscreen.png
# convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -u -i .lockscreen.png
rm .lockscreen.png

# !/bin/bash

dirlist='bash i3 lock neofetch polybar rofi vim xfce zsh'
echo $dirlist

#stow --adopt -nvt ~ $dirlist
stow --adopt -vt ~ $dirlist




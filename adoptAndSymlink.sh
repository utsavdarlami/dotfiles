# !/bin/bash

dirlist='bash i3 lock screen neofetch polybar rofi vim zsh mpd ncmpcpp alacritty'
echo $dirlist

stow --adopt -vt ~ $dirlist
#stow --adopt -vt ~ $dirlist




# !/bin/bash

dirlist='bash i3 lock neofetch polybar rofi vim zsh mpd ncmpcpp kitty'
echo $dirlist

#stow --adopt -nvt ~ $dirlist
stow --adopt -vt ~ $dirlist




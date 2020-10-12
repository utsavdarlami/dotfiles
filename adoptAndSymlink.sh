# !/bin/bash

dirlist="
            alacritty 
            bash 
            bspwm 
            i3 
            lock 
            mpd 
            ncmpcpp 
            neofetch 
            picom
            polybar 
            rofi 
            screen 
            sxhkd 
            vim 
            zsh 
        "
echo $dirlist

# -nvt for simulation ,, to check if everythings is safely linked
#stow --adopt -nvt ~ $dirlist
#stow * -nvt ~ $dirlist

# -vt for actual linking
stow --adopt -vt ~ $dirlist




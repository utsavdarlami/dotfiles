# !/bin/bash

dirlist="
            alacritty 
            bash 
            bspwm 
            i3 
            lock 
            mpd 
            mozilla
            ncmpcpp 
            nvim
            neofetch 
            picom
            polybar 
            rofi 
            screen 
            sxhkd 
            vim 
            Xresources
            zsh 
            zathura
        "
etc="
        X11
    "

echo $dirlist
echo $etc

# -nvt for simulation ,, to check if everythings is safely linked
#stow --adopt -nvt ~ $dirlist
#stow --adopt -nvt /etc/ $etc
#stow * -nvt ~ $dirlist

# -vt for actual linking
stow --adopt -vt ~ $dirlist
stow --adopt -vt /etc/ $etc




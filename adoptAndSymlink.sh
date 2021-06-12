# !/bin/bash
dirlist="
            alacritty 
            bash 
            bspwm 
            emacs
            i3 
            lock 
            mpd 
            mozilla
            ncmpcpp 
            nvim
            picom
            polybar 
            rofi
            screen 
            screenlayout
            sxhkd 
            vim 
            Xresources
            Xmodmap
            zsh 
            zathura
        "
etc="
        X11
    "

echo $dirlist
echo $etc

if [ $1 = "test" ]; then
    # -nvt for simulation ,, to check if everythings is safely linked
    stow --adopt -nvt ~ $dirlist
    stow --adopt -nvt /etc/ $etc
    stow * -nvt ~ $dirlist
else 
    #stow -vt for actual linking
    stow --adopt -vt ~ $dirlist
    stow --adopt -vt /etc/ $etc
fi

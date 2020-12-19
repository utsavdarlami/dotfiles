#!/usr/bin/env bash 
## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

rofi_command="rofi -theme themes/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
#shutdown=" "
shutdown="⏼ "
#shutdown="\0icon\x1f/usr/share/icons/Papirus/48x48/apps/system-shutdown.svg\n"
#reboot=" "
reboot="ﰇ"
lock=" "
#suspend="鈴"
logout=" "

# Variable passed to rofi
options="$shutdown\n$reboot\n$logout\n$lock"


chosen="$(echo -en "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 6)"
case $chosen in
    $shutdown)
        systemctl poweroff;;
    $reboot)
        systemctl reboot;;
    $logout)
        bspc quit;;
    $lock)
        betterlockscreen -l dim;;
esac


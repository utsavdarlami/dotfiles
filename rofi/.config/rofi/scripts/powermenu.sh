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
#reboot=" "
reboot="ﰇ"
#lock=""
#suspend="鈴"
logout=" "

# Variable passed to rofi
options="$shutdown\n$reboot\n$logout"


chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 6)"
case $chosen in
    $shutdown)
        systemctl poweroff;;
    $reboot)
        systemctl reboot;;
    $logout)
        bspc quit;;
esac


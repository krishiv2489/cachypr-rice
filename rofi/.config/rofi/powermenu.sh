#!/usr/bin/env bash

# Define the menu options with optional icons
shutdown="⏻ Shutdown"
reboot=" Reboot"
lock=" Lock"
suspend="󰒲 Suspend"
logout="󰗽 Logout"

# If Rofi passes no arguments, output the menu list
if [ -z "$1" ]; then
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown"
else
    # Execute the corresponding command based on the user's selection
    case "$1" in
        "$shutdown") systemctl poweroff ;;
        "$reboot") systemctl reboot ;;
        "$suspend") systemctl suspend ;;
        "$lock") hyprlock ;; # Replace with swaylock if you prefer
        "$logout") hyprctl dispatch exit ;;
    esac
fi

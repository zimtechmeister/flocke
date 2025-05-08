#!/bin/sh

menu() {
    options=" apps\n⏻ power\n󰅍 cliphist\n emoji" selected=$(echo -e $options |rofi -dmenu -p "menu" -i)

    if [[ $selected == " apps" ]]; then
        rofi -show drun
    elif [[ $selected == "⏻ power" ]]; then
        power-menu
    elif [[ $selected == "󰅍 cliphist" ]]; then
        cliphist list | rofi -dmenu | cliphist decode | wl-copy
    elif [[ $selected == " emoji" ]]; then
        rofimoji -a clipboard
    else
        echo "canceled"
    fi
}

menu

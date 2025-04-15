#!/bin/sh

export STATUS_FILE="$XDG_RUNTIME_DIR/keyboard.status"

enable_keyboard() {
    # printf "true" >"$STATUS_FILE"
    touch $STATUS_FILE
    hyprctl keyword '$LAPTOP_KB_ENABLED' "true" -r
}

disable_keyboard() {
    # printf "false" >"$STATUS_FILE"
    rm $STATUS_FILE
    hyprctl keyword '$LAPTOP_KB_ENABLED' "false" -r
}

if ! [ -f "$STATUS_FILE" ]; then
    enable_keyboard
else
    disable_keyboard
fi

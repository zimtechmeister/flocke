{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  wayland.windowManager = {
    hyprland = {
      settings = {
        "$mod" = "SUPER";
        bind = [
          # NOTE: terminal
          "$mod, Return, exec, ghostty"
          "$mod, semicolon, exec, /home/tim/dotfiles/scripts/rofi/scripts.sh"
          "$mod, R, exec, rofi -show drun"
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          "$mod, S, exec, screenshot"

          "$mod, Z, exit,"
          "$mod, Q, killactive,"
          "$mod, I, togglefloating,"

          "$mod, F, fullscreen, 1"
          "$mod SHIFT, F, fullscreen,"
          "$mod CTRL, F, fullscreenstate, 1"

          "$mod, O, pseudo,"
          "$mod, E, togglesplit,"

          "$mod, H, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, L, movewindow, r"

          "$mod, 1, focusWorkspaceOnCurrentMonitor, 1"
          "$mod, 2, focusWorkspaceOnCurrentMonitor, 2"
          "$mod, 3, focusWorkspaceOnCurrentMonitor, 3"
          "$mod, 4, focusWorkspaceOnCurrentMonitor, 4"
          "$mod, 5, focusWorkspaceOnCurrentMonitor, 5"
          "$mod, 6, focusWorkspaceOnCurrentMonitor, 6"
          "$mod, 7, focusWorkspaceOnCurrentMonitor, 7"
          "$mod, 8, focusWorkspaceOnCurrentMonitor, 8"
          "$mod, 9, focusWorkspaceOnCurrentMonitor, 9"
          "$mod, 0, focusWorkspaceOnCurrentMonitor, 10"

          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"
          "$mod SHIFT, 0, movetoworkspacesilent, 10"

          "$mod, Space, togglespecialworkspace, scratchpad"
          "$mod SHIFT, Space, movetoworkspacesilent, special:scratchpad"
        ];
        binde = [
          "$mod SHIFT CTRL, H, moveactive, -20 0"
          "$mod SHIFT CTRL, J, moveactive, 0 20"
          "$mod SHIFT CTRL, K, moveactive, 0 -20"
          "$mod SHIFT CTRL, L, moveactive, 20 0"

          "$mod CTRL, H, resizeactive, -20 0"
          "$mod CTRL, J, resizeactive, 0 20"
          "$mod CTRL, K, resizeactive, 0 -20"
          "$mod CTRL, L, resizeactive, 20 0"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}

{
  # pkgs,
  # inputs,
  ...
}: {
  wayland.windowManager = {
    hyprland = {
      settings = {
        bind = [
          "SUPER, Return, exec, ghostty"

          # Anyrun
          # "SUPER, Space, exec, anyrun"
          # "SUPER, V, exec, cliphist list | anyrun --show-results-immediately true --plugins ${inputs.anyrun.packages.${pkgs.system}.stdin}/lib/libstdin.so | cliphist decode | wl-copy"

          # walker
          "SUPER, Space, exec, walker"
          "SUPER, V, exec, walker -m clipboard"

          "SUPER, S, exec, screenshot"

          "SUPER SHIFT, Z, exit,"
          "SUPER, Q, killactive,"
          "SUPER, I, togglefloating,"

          # fullscreen 0 -> no gaps no bar
          # fullscreen 1 -> only maximize
          "SUPER, F, fullscreen, 0"
          # exit fullscreen but window wont notice
          # https://wiki.hypr.land/Configuring/Dispatchers/#fullscreenstate
          "SUPER SHIFT, F, fullscreenstate, 1"
          "SUPER CTRL, F, fullscreenstate, 0 2"

          # only in dwindle layout
          "SUPER, O, pseudo,"
          "SUPER, E, togglesplit,"

          # scrolling layout
          "SUPER SHIFT, O, layoutmsg, colresize, +0.25"
          "SUPER SHIFT, E, layoutmsg, colresize, -0.25"

          "SUPER, H, movefocus, l"
          "SUPER, l, movefocus, r"
          "SUPER, k, movefocus, u"
          "SUPER, j, movefocus, d"

          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, J, movewindow, d"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, L, movewindow, r"

          "SUPER, 1, focusWorkspaceOnCurrentMonitor, 1"
          "SUPER, 2, focusWorkspaceOnCurrentMonitor, 2"
          "SUPER, 3, focusWorkspaceOnCurrentMonitor, 3"
          "SUPER, 4, focusWorkspaceOnCurrentMonitor, 4"
          "SUPER, 5, focusWorkspaceOnCurrentMonitor, 5"
          "SUPER, 6, focusWorkspaceOnCurrentMonitor, 6"
          "SUPER, 7, focusWorkspaceOnCurrentMonitor, 7"
          "SUPER, 8, focusWorkspaceOnCurrentMonitor, 8"
          "SUPER, 9, focusWorkspaceOnCurrentMonitor, 9"
          "SUPER, 0, focusWorkspaceOnCurrentMonitor, 10"

          "SUPER SHIFT, 1, movetoworkspacesilent, 1"
          "SUPER SHIFT, 2, movetoworkspacesilent, 2"
          "SUPER SHIFT, 3, movetoworkspacesilent, 3"
          "SUPER SHIFT, 4, movetoworkspacesilent, 4"
          "SUPER SHIFT, 5, movetoworkspacesilent, 5"
          "SUPER SHIFT, 6, movetoworkspacesilent, 6"
          "SUPER SHIFT, 7, movetoworkspacesilent, 7"
          "SUPER SHIFT, 8, movetoworkspacesilent, 8"
          "SUPER SHIFT, 9, movetoworkspacesilent, 9"
          "SUPER SHIFT, 0, movetoworkspacesilent, 10"

          # "SUPER, Space, togglespecialworkspace, scratchpad"
          # "SUPER SHIFT, Space, movetoworkspacesilent, special:scratchpad"
        ];
        binde = [
          "SUPER SHIFT CTRL, H, moveactive, -20 0"
          "SUPER SHIFT CTRL, J, moveactive, 0 20"
          "SUPER SHIFT CTRL, K, moveactive, 0 -20"
          "SUPER SHIFT CTRL, L, moveactive, 20 0"

          "SUPER CTRL, H, resizeactive, -20 0"
          "SUPER CTRL, J, resizeactive, 0 20"
          "SUPER CTRL, K, resizeactive, 0 -20"
          "SUPER CTRL, L, resizeactive, 20 0"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
  };
}

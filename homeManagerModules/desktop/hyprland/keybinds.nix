{
  pkgs,
  lib,
  ...
}: let
  jq = lib.getExe pkgs.jq;
  focusDown = pkgs.writeShellScript "focus-down" ''
    # Get the initial active window address
    # We use -j for JSON output and jq for reliable parsing
    OLD_WINDOW=$(hyprctl activewindow -j | ${jq} -r '.address')

    # Attempt to move focus down
    hyprctl dispatch layoutmsg focus down

    # Get the new active window address
    NEW_WINDOW=$(hyprctl activewindow -j | ${jq} -r '.address')

    # Compare the two addresses
    if [ "$OLD_WINDOW" == "$NEW_WINDOW" ]; then
        # If they are the same, we reached the end of the layout
        # Move to the next workspace on the current monitor
        hyprctl dispatch focusworkspaceoncurrentmonitor +1
    fi
  '';

  focusUp = pkgs.writeShellScript "focus-up" ''
    # Get the initial active window address
    # We use -j for JSON output and jq for reliable parsing
    OLD_WINDOW=$(hyprctl activewindow -j | ${jq} -r '.address')

    # Attempt to move focus up
    hyprctl dispatch layoutmsg focus up

    # Get the new active window address
    NEW_WINDOW=$(hyprctl activewindow -j | ${jq} -r '.address')

    # Compare the two addresses
    if [ "$OLD_WINDOW" == "$NEW_WINDOW" ]; then
        # If they are the same, we reached the end of the layout
        # Move to the next workspace on the current monitor
        hyprctl dispatch focusworkspaceoncurrentmonitor -1
    fi
  '';
in {
  wayland.windowManager = {
    hyprland = {
      settings = {
        bind = [
          "SUPER, Return, exec, ghostty"

          # Anyrun
          # "SUPER, Space, exec, anyrun"
          # "SUPER, V, exec, cliphist list | anyrun --show-results-immediately true --plugins ${inputs.anyrun.packages.${pkgs.stdenv.hostPlatform.system}.stdin}/lib/libstdin.so | cliphist decode | wl-copy"

          # walker
          # "SUPER, Space, exec, walker"
          # "SUPER, V, exec, walker -m clipboard"

          # vicinae
          # "SUPER SHIFT, Space, exec, vicinae toggle"
          # "SUPER SHIFT, V, exec, vicinae vicinae://extensions/vicinae/clipboard/history"

          # noctalia-shell
          "SUPER, Space, exec, noctalia-shell ipc call launcher toggle"
          "SUPER, V, exec, noctalia-shell ipc call launcher clipboard"

          "SUPER SHIFT, N, exec, noctalia-shell ipc call bar toggle"

          "SUPER SHIFT, M, exec, noctalia-shell ipc call volume muteInput"

          "SUPER, S, exec, screenshot"

          "SUPER SHIFT, Z, exit,"
          "SUPER, Q, killactive,"
          "SUPER, D, togglefloating,"
          "SUPER SHIFT, D, pin,"

          # fullscreen 0 -> no gaps no bar
          # fullscreen 1 -> only maximize
          "SUPER, F, fullscreen, 0"
          "SUPER SHIFT, F, fullscreen, 1"
          # exit fullscreen but window wont notice
          "SUPER CTRL, F, fullscreenstate, -1 2"

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

          "SUPER, P, layoutmsg, promote"

          "SUPER, H, layoutmsg, focus l"
          "SUPER, J, exec, ${focusDown}"
          "SUPER, K, exec, ${focusUp}"
          "SUPER, L, layoutmsg, focus r"

          "SUPER, left, focusmonitor, l"
          "SUPER, down, focusmonitor, d"
          "SUPER, up, focusmonitor, u"
          "SUPER, right, focusmonitor, r"

          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, J, movewindow, d"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, L, movewindow, r"
        ];
        binde = [
          "SUPER CTRL, H, layoutmsg, colresize -conf"
          "SUPER CTRL, L, layoutmsg, colresize +conf"

          "SUPER CTRL, J, resizeactive, 0 20"
          "SUPER CTRL, K, resizeactive, 0 -20"
        ];
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
        bindl = [
          ", switch:on:Lid Switch, exec, noctalia-shell ipc call sessionMenu lockAndSuspend"
        ];
        gesture = [
          "3, vertical, workspace"
          "3, right, dispatcher, layoutmsg, focus r"
          "3, left, dispatcher, layoutmsg, focus l"
        ];
      };
    };
  };
}

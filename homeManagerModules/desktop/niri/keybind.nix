{
  config,
  # inputs,
  # pkgs,
  ...
}: {
  programs.niri.settings = {
    # NOTE: "niri msg action help" to display availabe actions
    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in {
      "super+return".action = spawn "ghostty";
      # "super+space".action = spawn "anyrun";
      # "super+v".action = sh "cliphist list | anyrun --show-results-immediately true --plugins ${inputs.anyrun.packages.${pkgs.system}.stdin}/lib/libstdin.so | cliphist decode | wl-copy";
      # "super+space".action = spawn "walker";
      # "super+v".action = sh "walker -m clipboard";
      "super+space".action = spawn "vicinae toggle";
      "super+v".action = spawn "vicinae vicinae://extensions/vicinae/clipboard/history";

      "super+s".action = spawn "screenshot";
      # "super+shift+s".action = screenshot; # depricated?

      "super+shift+z".action = quit;
      "super+q".action = close-window;
      "super+n".action = toggle-overview;

      "super+f".action = maximize-column;
      "super+shift+f".action = fullscreen-window;
      "super+ctrl+f".action = toggle-windowed-fullscreen; # fake fullscreen

      "super+i".action = toggle-window-floating;
      "super+shift+i".action = switch-focus-between-floating-and-tiling;

      "super+h".action = focus-column-or-monitor-left;
      "super+l".action = focus-column-or-monitor-right;
      "super+k".action = focus-window-or-workspace-up;
      "super+j".action = focus-window-or-workspace-down;

      "super+shift+h".action = move-column-left-or-to-monitor-left;
      "super+shift+l".action = move-column-right-or-to-monitor-right;
      "super+shift+k".action = move-window-up-or-to-workspace-up;
      "super+shift+j".action = move-window-down-or-to-workspace-down;

      "super+ctrl+h".action = set-column-width "-10%";
      "super+ctrl+l".action = set-column-width "+10%";
      "super+ctrl+j".action = move-workspace-down;
      "super+ctrl+k".action = move-workspace-up;

      "super+alt+h".action = focus-monitor-left;
      "super+alt+l".action = focus-monitor-right;
      "super+alt+k".action = focus-monitor-up;
      "super+alt+j".action = focus-monitor-down;

      "super+alt+shift+h".action = move-workspace-to-monitor-left;
      "super+alt+shift+l".action = move-workspace-to-monitor-right;
      "super+alt+shift+k".action = move-workspace-to-monitor-up;
      "super+alt+shift+j".action = move-workspace-to-monitor-down;
    };
  };
}

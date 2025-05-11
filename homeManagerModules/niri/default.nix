{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
  ];
  options.niri.enable = lib.mkEnableOption "enables niri";
  config = lib.mkIf config.niri.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
      settings = {
        outputs = {
          "DP-1" = {
            scale = 1.0;
            position = {
              x = 0;
              y = 0;
            };
          };
        };
        # this is not optimal
        spawn-at-startup = [
          {command = ["wl-paste" "--watch" "cliphist" "store"];}
          {command = ["systemctl" "--user" "start" "hyprpolkitagent"];}
          {command = ["waybar"];}
          {command = ["swaync"];}
        ];
        input = {
          keyboard.xkb.layout = "eu";
        };
        layout = {
          border = {
            enable = true;
            width = 1;
            active.color = "#8a9e6b";
            inactive.color = "#2a2e2a";
          };
        };
        # NOTE: "niri msg action" to display availabe actions
        binds = with config.lib.niri.actions; {
          "Super+Return".action = spawn "ghostty";
          "Super+R".action = spawn "rofi -show drun"; # does not work
          "Super+S".action = spawn "menu";

          "Super+Shift+Z".action = quit;
          "Super+Q".action = close-window;

          "Super+H".action = focus-column-left;
          "Super+L".action = focus-column-right;
          "Super+K".action = focus-window-up;
          "Super+J".action = focus-window-down;

          "Super+Shift+H".action = move-column-left;
          "Super+Shift+L".action = move-column-right;
          "Super+Shift+K".action = move-window-up;
          "Super+Shift+J".action = move-window-down;

          # NOTE: workspaces are interesting here probaply need to name them
          "Super+1".action = focus-workspace 1;
          "Super+2".action = focus-workspace 2;
          "Super+3".action = focus-workspace 3;
          "Super+4".action = focus-workspace 4;
          "Super+5".action = focus-workspace 5;
          "Super+6".action = focus-workspace 6;
          "Super+7".action = focus-workspace 7;
          "Super+8".action = focus-workspace 8;
          "Super+9".action = focus-workspace 9;
          "Super+0".action = focus-workspace 10;

          # "Super+Shift+1".action = move-window-to-workspace 1;
          # "Super+Shift+2".action = move-window-to-workspace 2;
          # "Super+Shift+3".action = move-window-to-workspace 3;
          # "Super+Shift+4".action = move-window-to-workspace 4;
          # "Super+Shift+5".action = move-window-to-workspace 5;
          # "Super+Shift+6".action = move-window-to-workspace 6;
          # "Super+Shift+7".action = move-window-to-workspace 7;
          # "Super+Shift+8".action = move-window-to-workspace 8;
          # "Super+Shift+9".action = move-window-to-workspace 9;
          # "Super+Shift+0".action = move-window-to-workspace 10;
        };
      };
    };
  };
}

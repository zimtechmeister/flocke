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
        binds = with config.lib.niri.actions; {
          "Super+Return".action = spawn "ghostty";
          "Super+R".action = spawn "rofi -show drun";

          "Super+Shift+Z".action = quit;
          "Super+Q".action = close-window;
          # "Super+O".action = toggle-overview;

          "Super+H".action = focus-column-left;
          "Super+L".action = focus-column-right;
          "Super+K".action = focus-window-up;
          "Super+J".action = focus-window-down;

          "Super+Shift+H".action = move-column-left;
          "Super+Shift+L".action = move-column-right;
          "Super+Shift+K".action = move-window-up;
          "Super+Shift+J".action = move-window-down;

          "Super+N".action = focus-workspace-down;
          "Super+P".action = focus-workspace-up;
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

          "Super+Shift+N".action = move-workspace-down;
          "Super+Shift+P".action = move-workspace-up;

          "Super+Ctrl+N".action = move-column-to-workspace-down;
          "Super+Ctrl+P".action = move-column-to-workspace-up;
        };
      };
    };
  };
}

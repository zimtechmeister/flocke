{
  pkgs,
  lib,
  config,
  ...
}: let
  swayncConfig = {
    "$schema" = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
    positionX = "center";
    positionY = "top";
    control-center-margin-top = 10;
    control-center-margin-bottom = 10;
    control-center-margin-right = 10;
    control-center-margin-left = 10;
    widgets = [
      "buttons-grid"
      "dnd"
      "title"
      "notifications"
      "volume"
      "mpris"
    ];
    widget-config = {
      buttons-grid.actions = [
        {
          label = "󰐥";
          command = "systemctl poweroff";
        }
        {
          label = "󰑐";
          command = "systemctl reboot";
        }
        {
          label = "󰤄";
          command = "systemctl suspend";
        }
        {
          label = "";
          comamnd = "systemctl lock-session";
        }
        {
          label = "󰈆";
          command = "hyprctl dispatch exit";
        }
      ];
      dnd = {
        text = "Do not disturb";
      };
      title = {
        text = "Notifications";
        clear-all-button = true;
        button-text = "󰆴";
      };
      volume = {
        label = "󰕾";
      };
    };
  };
in {
  options = {
    swaync.enable =
      lib.mkEnableOption "enables swaync";
  };

  config = lib.mkIf config.swaync.enable {
    home = {
      packages = [pkgs.swaynotificationcenter];
      file = {
        ".config/swaync/config.json".text = builtins.toJSON swayncConfig;
        ".config/swaync/style.css".source = ./style.css;
      };
    };
  };
}

{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  swayncConfig = {
    "$schema" = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
    positionX = "right";
    positionY = "top";
    layer = "overlay";
    control-center-layer = "top";
    layer-shell = true;
    cssPriority = "application";
    control-center-width = 380;
    control-center-margin-top = 0;
    control-center-margin-bottom = 0;
    control-center-margin-right = 0;
    control-center-margin-left = 0;

    notification-2fa-action = true;
    notification-inline-replies = false;
    notification-window-width = 380;
    notification-icon-size = 48;
    notification-body-image-height = 180;
    notification-body-image-width = 180;
    timeout = 8;
    timeout-low = 4;
    timeout-critical = 0;
    fit-to-screen = true;
    keyboard-shortcuts = true;
    image-visibility = "when-available";
    transition-time = 150;
    hide-on-clear = true;
    hide-on-action = true;
    script-fail-notify = true;
    widgets = [
      "buttons-grid"
      "dnd"
      "title"
      "notifications"
      "volume"
      "backlight"
      "mpris"
    ];
    widget-config = {
      buttons-grid.actions = [
        {
          label = "󰐥";
          command = "systemctl poweroff";
          tooltip = "shutdown";
        }
        {
          label = "󰑐";
          command = "systemctl reboot";
          tooltip = "reboot";
        }
        {
          label = "󰤄";
          command = "systemctl suspend";
          tooltip = "suspend";
        }
        {
          label = "";
          comamnd = "systemctl lock-session";
          tooltip = "lock";
        }
        {
          label = "󰈆";
          command = "hyprctl dispatch exit";
          tooltip = "log out";
        }
        {
          label = ""; # TODO: toggle option 󰖚
          # command = "hyprsunset -t 5000 -g 80";
          command = "hyprctl hyprsunset temperature 5000";
          tooltip = "eye saver";
        }
        {
          label = "";
          # command = "killall hyprsunset";
          command = "hyprctl hyprsunset identity";
          tooltip = "turn off eye saver";
        }
        # {
        #   label = "";
        #   command = "anyrun --show-results-immediately true --plugins ${inputs.anyrun.packages.${pkgs.system}.randr}/lib/librandr.so";
        #   tooltip = "randr";
        # }
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
        step = 5;
      };
      backlight = {
        label = "󰃞";
        step = 5;
      };
    };
  };
in {
  options.swaync.enable =
    lib.mkEnableOption "enables swaync";

  config = lib.mkIf config.swaync.enable {
    home = {
      packages = [pkgs.swaynotificationcenter];
      file = {
        ".config/swaync/config.json".text = builtins.toJSON swayncConfig;
        # ".config/swaync/style.css".source = ./style.css;
      };
    };
  };
}

{
  lib,
  config,
  ...
}: let
  clockActions = {
    desktop = "swaync-client -t -sw";
    t480 = "toggle-keyboard";
  };
  clockAction = builtins.getAttr (config.waybar.config) clockActions;
in {
  imports = [
    ./style.nix
  ];
  options.waybar = {
    enable = lib.mkEnableOption "enables waybar";
    config = lib.mkOption {
      default = null;
      description = ''
        waybar config
      '';
    };
  };
  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        # target = "niri.service";
      };
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom"; # Waybar position (top|bottom|left|right)
          height = 24; # Waybar height (to be removed for auto height)
          spacing = 4;
          reload_style_on_change = true;

          # Choose the order of the modules
          modules-left = [
            "hyprland/workspaces"
            "niri/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "idle_inhibitor"
            # "backlight"
            # "group/backlight"
            "network"
            "battery"
            # "pulseaudio"
            # "group/audio"
            "tray"
            "custom/swaync"
          ];

          # Modules configuration

          "hyprland/workspaces" = {
            all-outputs = true; # how to treat workspaces on different monitors
            move-to-monitor = true;
            show-special = true; # does not respect when changing monitor
          };

          tray = {
            show-passive-items = true;
            spacing = 8;
          };

          network = {
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format-wifi = "{icon}";
            format-ethernet = "󰈀";
            format-linked = "󰌷";
            format-disconnected = "󰤮";
            tooltip = true;
            tooltip-format-wifi = "{essid} {signalStrength}%";
            tooltip-format-ethernet = "{ipaddr}/{cidr}";
            tooltip-format-linked = "{ifname} (No IP)";
            tooltip-format-disconnected = "Disconnected";
            on-click = "ghostty -e nmtui";
          };

          pulseaudio = {
            format = "{icon}"; # add {format_source} for mic volume
            format-bluetooth = "{icon} ";
            format-bluetooth-muted = "󰝟 ";
            format-muted = "󰝟";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              default = ["󰕿" "󰖀" "󰕾"];
            };
            on-click-right = "ghostty -e pulsemixer";
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            tooltip = true;
            tooltip-format = "{volume}%";
          };

          mpris = {
            format = "{status_icon}";
            status-icons = {
              playing = "";
              paused = "";
              stopped = "";
            };
          };

          backlight = {
            # device = "acpi_video1";
            format = "{icon}";
            scroll-step = 10;
            # format-icons = ["󰄰" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
            format-icons = ["󰃞" "󰃟" "󰃠"];
            on-scroll-up = "brightnessctl set +10%";
            on-scroll-down = "brightnessctl set 10%-";
            tooltip = true;
            tooltip-format = "{percent}%";
          };

          "custom/swaync" = {
            format = "{icon}";
            format-icons = {
              notification = "󱅫";
              none = "󰂚";
              dnd-notification = "󰂠";
              dnd-none = "󰂠";
              inhibited-notification = "󱅫";
              inhibited-none = "󰂚";
              dnd-inhibited-notification = "󰂠";
              dnd-inhibited-none = "󰂠";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
            tooltip = false;
          };

          battery = {
            states = {
              # good = 95;
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-full = "{icon}";
            format-time = "{H}:{M}";
            # format-charging = "{capacity}% ";
            # format-plugged = "{capacity}% ";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            tooltip-format = "{timeTo} {capacity}%";
          };

          clock = {
            format = "{:%H:%M}";
            tooltip-format = "{:%A %d.%m.%y}";
            on-click = clockAction;
            # on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "󰒳";
              deactivated = "󰒲";
            };
          };

          "group/audio" = {
            orientation = "inherit";
            drawer = {
              transition-duration = 500;
              transition-left-to-right = true;
            };
            modules = [
              "pulseaudio" # First element is the "group leader" and won't ever be hidden
              "pulseaudio/slider"
            ];
          };

          "group/backlight" = {
            orientation = "inherit";
            drawer = {
              transition-duration = 500;
              transition-left-to-right = false;
            };
            modules = [
              "backlight" # First element is the "group leader" and won't ever be hidden
              "backlight/slider"
            ];
          };

          "group/power" = {
            orientation = "inherit";
            drawer = {
              transition-duration = 500;
              transition-left-to-right = true;
            };
            modules = [
              "custom/rofi" # First element is the "group leader" and won't ever be hidden
              "custom/shutdown"
              "custom/reboot"
              "custom/suspend"
              "custom/lock"
              "custom/quit"
            ];
          };
          "custom/shutdown" = {
            format = "󰐥";
            tooltip-format = "shutdown";
            on-click = "shutdown now";
          };
          "custom/reboot" = {
            format = "󰜉";
            tooltip-format = "reboot";
            on-click = "reboot";
          };
          "custom/suspend" = {
            format = "󰤄";
            tooltip-format = "suspend";
            on-click = "systemctl suspend";
          };
          "custom/lock" = {
            format = "";
            tooltip-format = "lock";
            on-click = "systemclt lock-session";
          };
          "custom/quit" = {
            format = "󰈆";
            tooltip-format = "quit";
            on-click = "hyprctl dispatch exit";
          };

          cpu = {
            format = " {usage}%";
            tooltip = false;
          };

          temperature = {
            format = "{icon} {temperatureC}°C";
            format-icons = ["" "" "" "" ""];
            critical-threshold = 80;
            format-critical = " {temperatureC}°C";
          };
        };
      };
    };
  };
}

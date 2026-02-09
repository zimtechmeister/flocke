{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./keybind.nix
    ./rules.nix
  ];
  options.my.niri.enable = lib.mkEnableOption "enables niri";
  config = lib.mkIf config.my.niri.enable {
    home.packages = [
      pkgs.xwayland-satellite
    ];
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      # NOTE: nix niri-falke configuration docs
      # https://github.com/sodiboo/niri-flake/blob/main/docs.md#programsnirisettings
      settings = {
        hotkey-overlay.skip-at-startup = true;
        screenshot-path = "~/Pictures/screenshot_%Y-%m-%d_%H:%M:%S.png";
        prefer-no-csd = true;
        spawn-at-startup = [
          # {command = ["wl-paste" "--watch" "cliphist" "store"];}
          # {command = ["systemctl" "--user" "start" "hyprpolkitagent"];}
          {command = ["systemctl" "--user" "start" "xwayland-satellite"];}
        ];

        environment = {
          CLUTTER_BACKEND = "wayland";
          GDK_BACKEND = "wayland,x11";
          MOZ_ENABLE_WAYLAND = "1";
          NIXOS_OZONE_WL = "1";
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";

          XDG_SESSION_TYPE = "wayland";
          XDG_CURRENT_DESKTOP = "niri";
          DISPLAY = ":0";

          # QT_QPA_PLATFORM = "wayland";
          # DISPLAY = ":0";
        };

        overview = {
          backdrop-color = null;
          workspace-shadow.enable = false;
        };

        outputs = {
          "Microstep Optix MAG24C 0000000000001" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 143.99600;
            };
            scale = 1.0;
            position = {
              x = 0;
              y = 0;
            };
            variable-refresh-rate = "on-demand";
            focus-at-startup = true;
          };

          "HDMI-A-2" = {
            mode = {
              width = 1920;
              height = 1200;
              refresh = 59.95000;
            };
            scale = 1.0;
            position = {
              x = 1920;
              y = 0;
            };
            transform = {
              flipped = false;
              rotation = 0;
            };
          };
        };

        input = {
          warp-mouse-to-focus.enable = true;
          focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "20%";
          };

          keyboard.xkb = {
            layout = "eu";
            # options = "caps:swapescape";
          };

          mouse = {
            accel-profile = "flat";
          };

          touchpad = {
            tap = true;
            dwt = true;
            drag = true;
            natural-scroll = false;
          };
        };

        layout = {
          gaps = 16;
          focus-ring.enable = false;
          center-focused-column = "never";
          default-column-width.proportion = 0.5;
          shadow.enable = false;
          background-color = "#00000000";
          border = {
            enable = true;
            width = 1;
            active.color = "#${config.stylix.base16Scheme.base05}";
            inactive.color = "#${config.stylix.base16Scheme.base00}";
            urgent.color = "#${config.stylix.base16Scheme.base08}";
          };
          insert-hint = {
            enable = true;
            display.color = "#${config.stylix.base16Scheme.base0B}80";
          };
        };
      };
    };
  };
}

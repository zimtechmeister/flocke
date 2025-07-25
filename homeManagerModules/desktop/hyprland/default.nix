{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  monitorLayouts = {
    desktop = [
      "desc:Microstep Optix MAG24C 0000000000001, preferred, 0x0, 1"
      "desc:Dell Inc. DELL U2412M 0FFXD33I1C7L, preferred, 1920x0, 1"
      ", preferred, auto, 1, mirror, eDP-"
    ];
    t480 = [
      "eDP-1, preferred, 0x0, 1"
      "desc:Microstep Optix MAG24C 0000000000001, preferred, 1920x0, 1"
      "desc:Dell Inc. DELL U2412M 0FFXD33I1C7L, preferred, 3840x0, 1"
      ", preferred, auto, 1, mirror, eDP-"
    ];
  };
  monitorLayout = builtins.getAttr (config.hyprland.monitorLayout) monitorLayouts;
in {
  imports = [
    ./keybinds.nix
    # NOTE: after enabeling a plugin restart hyprland
    # ./plugins/hyprscrolling.nix
    ./plugins/hyprbars.nix
  ];
  options.hyprland = {
    enable = lib.mkEnableOption "enables hyprland";
    monitorLayout = lib.mkOption {
      default = null;
      description = ''
        hyprland monitor layout
      '';
    };
  };
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
        # NOTE: dont know how to do the first line in settings
        extraConfig = ''
          $LAPTOP_KB_ENABLED = true
          device {
            name = at-translated-set-2-keyboard
            enabled = $LAPTOP_KB_ENABLED
            kb_options = caps:swapescape
          }
        '';
        settings = {
          monitor = monitorLayout;
          exec-once = [
            "wl-paste --watch cliphist store"
            # "systemctl --user start hyprpolkitagent"
            "waybar"
            "swaync"
          ];
          input = {
            kb_layout = "eu, de, us";
            accel_profile = "flat";
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_invert = false;
            workspace_swipe_use_r = true;
          };
          general = {
            border_size = lib.mkDefault 2;
            gaps_in = 4;
            gaps_out = 8;
            "col.active_border" = lib.mkOverride 10000 "rgb(${config.stylix.base16Scheme.base05})";
            #col.active_border = rgb(ea6962) rgb(e78a4e) rgb(d8a657) rgb(a9b665) rgb(89b482) rgb(7daea3) rgb(d3869b) 0deg
            # NOTE: transparent
            "col.inactive_border" = lib.mkOverride 10000 "rgba(${config.stylix.base16Scheme.base11}00)";

            layout = "dwindle";
            resize_on_border = true;
            snap = {
              enabled = true;
            };
          };
          decoration = {
            rounding = 4;
            blur = {
              enabled = true;
              size = 4;
              passes = 4;
              ignore_opacity = true;
            };
            shadow = {
              enabled = true;
              range = 4;
              render_power = 1;
              color = lib.mkForce "rgb(${config.stylix.base16Scheme.base11})";
              # color_inactive = "rgb(d3869b)"; # if not set, will fall back to color
            };
          };
          animations = {
            enabled = false;
          };
          dwindle = {
            force_split = 2;
            preserve_split = true;
          };
          misc = {
            # solid background_color (wallpaper)
            background_color = lib.mkForce "rgb(${config.stylix.base16Scheme.base11})";
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            # NOTE: font
            font_family = config.stylix.fonts.serif.name;
            mouse_move_enables_dpms = false;
            key_press_enables_dpms = true;
            new_window_takes_over_fullscreen = true;
          };
          windowrulev2 = lib.mkDefault [
            "suppressevent maximize, class:.*"
          ];
          layerrule = [
            "dimaround, anyrun"
          ];
          workspace = lib.mkDefault [
            "special:scratchpad, gapsout:32, gapsin:4"
          ];
        };
      };
    };
  };
}

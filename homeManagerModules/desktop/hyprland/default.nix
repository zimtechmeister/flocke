{
  pkgs,
  lib,
  config,
  ...
}: let
  monitorLayouts = {
    desktop = [
      "desc:Microstep Optix MAG24C 0000000000001, preferred, 0x0, 1"
      "desc:Dell Inc. DELL U2412M 0FFXD33I1C7L, preferred, 1920x0, 1"
      ", preferred, auto, 1, mirror, DP-1"
    ];
    t480 = [
      "eDP-1, preferred, 0x0, 1"
      "desc:Microstep Optix MAG24C 0000000000001, preferred, 1920x0, 1"
      "desc:Dell Inc. DELL U2412M 0FFXD33I1C7L, preferred, 3840x0, 1"
      ", preferred, auto, 1, mirror, eDP-1"
    ];
    optiplex3000 = [
      "desc:Microstep Optix MAG24C 0000000000001, preferred, 0x0, 1"
      "desc:Dell Inc. DELL U2412M 0FFXD33I1C7L, preferred, 1920x0, 1"
      ", preferred, auto, 1, mirror, DP-1"
    ];
  };
  monitorLayout = builtins.getAttr (config.my.hyprland.monitorLayout) monitorLayouts;

  start-hyprland = pkgs.writeShellScript "start-hyprland" ''
    # if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    if [[ -z $DISPLAY ]] && [[ "$XDG_VTNR" = 1 ]]; then
      exec start-hyprland
    fi
  '';
in {
  imports = [
    ./keybinds.nix
    # NOTE: after enabeling a plugin restart hyprland
    ./plugins/hyprscrolling.nix
    # ./plugins/hyprbars.nix
  ];
  options.my.hyprland = {
    enable = lib.mkEnableOption "enables hyprland";
    monitorLayout = lib.mkOption {
      default = null;
      description = ''
        hyprland monitor layout
      '';
    };
    plugins.hyprscrolling.enable = lib.mkEnableOption "enables hyprscrolling plugin";
  };
  config = lib.mkIf config.my.hyprland.enable {
    programs.fish.loginShellInit = ''
      ${start-hyprland}
    '';
    wayland.windowManager.hyprland = {
      enable = true;
      # important for xdg-desktop-portal-hyprland to work and not uwsm dependent
      systemd.variables = [
        "--all"
      ];
      # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
      package = null;
      portalPackage = null;
      # NOTE: dont know how to do the first line in settings
      extraConfig = ''
        $LAPTOP_KB_ENABLED = true
        device {
          name = at-translated-set-2-keyboard
          enabled = $LAPTOP_KB_ENABLED
        }
        source = ~/.config/hypr/monitors.conf
      '';
      settings = {
        monitor = monitorLayout;
        exec-once = [
          "touch ~/.config/hypr/monitors.conf"
        ];
        input = {
          kb_layout = "eu, de, us";
          accel_profile = "flat";
        };
        general = {
          border_size = lib.mkDefault 2;
          gaps_in = 5;
          gaps_out = 10;
          # NOTE:: mkOverride 10000 does not have the same effect as mkForce?
          "col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base05})";
          #col.active_border = rgb(ea6962) rgb(e78a4e) rgb(d8a657) rgb(a9b665) rgb(89b482) rgb(7daea3) rgb(d3869b) 0deg
          # NOTE: transparent
          "col.inactive_border" = lib.mkForce "rgba(${config.stylix.base16Scheme.base11}00)";

          layout = "dwindle";
          resize_on_border = true;
          snap = {
            enabled = true;
          };
        };
        decoration = {
          rounding = 0;
          rounding_power = 2;
          blur = {
            enabled = true;
            size = 3;
            passes = 2;
            vibrancy = 0.1696;
            ignore_opacity = true;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = lib.mkForce "rgb(${config.stylix.base16Scheme.base11})";
            color_inactive = lib.mkForce "rgba(${config.stylix.base16Scheme.base11}00)"; # if not set, will fall back to color
          };
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
        };
        windowrule = lib.mkDefault [
          "match:class .*, suppress_event maximize"
        ];
        layerrule = [
          # "dimaround, vicinae"
        ];
        workspace = lib.mkDefault [
          "special:scratchpad, gapsout:32, gapsin:4"
        ];
      };
    };
  };
}

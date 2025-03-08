{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  monitorLayouts = {
    PC = [
      "desc:Microstep Optix MAG24C 0000000000001, preferred, 0x0, 1"
      "desc:Dell Inc. DELL U2412M 0FFXD33I1C7L, preferred, 1920x0, 1"
      ", preferred, auto, 1, mirror, eDP-"
    ];
    t480 = [
      "eDP-1, preferred, 0x0, 1"
      "desc:Microstep Optix MAG24C 0000000000001, preferred, 1920x0, 1"
      "desc:Dell Inc. DELL U2412M 0FFXD33I1C7L, preferred, 3840, 1"
      ", preferred, auto, 1, mirror, eDP-"
    ];
  };
  monitorLayout = builtins.getAttr (config.monitorLayout) monitorLayouts;

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &
    systemctl --user start hyprpolkitagent &
    hyprpaper &
    waybar &
    hypridle &
    swaync &
  '';
in {
  # imports = [
  #   ./keybinds.nix
  # ];
  options = {
    hyprland.enable =
      lib.mkEnableOption "enables hyprland";
    monitorLayout = lib.mkOption {
      default = "PC";
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
        settings = {
          monitor = monitorLayout;
          exec-once = ''${startupScript}/bin/start'';
          input = {
            kb_layout = "eu, de, us";
            accel_profile = "flat";
          };
          # TODO: only laptop
          device = {
            name = "at-translated-set-2-keyboard";
            kb_options = "caps:swapescape";
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_use_r = true;
          };
          general = {
            border_size = 2;
            gaps_in = 4;
            gaps_out = 8;
            # NOTE: style
            "col.inactive_border" = "rgb(1d2021)";
            "col.active_border" = "rgb(d4be98)";
            #col.active_border = rgb(ea6962) rgb(e78a4e) rgb(d8a657) rgb(a9b665) rgb(89b482) rgb(7daea3) rgb(d3869b) 0deg

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
              range = 4;
              render_power = 1;
              # NOTE: style
              color = "rgb(282828)";
              # color_inactive = "rgb(d3869b)"; # if not set, will fall back to color
            };
          };
          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 4, default"
              "windowsOut, 1, 4, default, popin 80%"
              "layers, 1, 4, default, popin 80%"
              "fade, 1, 4, default"
              "border, 1, 16, default"
              "borderangle, 0, 8, default"
              "workspaces, 1, 4, default, fade"
            ];
          };
          dwindle = {
            force_split = 2;
            preserve_split = true;
          };
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            # NOTE: font
            font_family = "FiraCode Nerd Font";
            mouse_move_enables_dpms = false;
            key_press_enables_dpms = true;
            new_window_takes_over_fullscreen = true;
          };
          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "float, title:Picture-in-Picture"
          ];
          workspace = "special:scratchpad, gapsout:64, gapsin:32";

          "$mod" = "SUPER";
          bind = [
            # NOTE: terminal
            "$mod, Return, exec, ghostty"
            "$mod, semicolon, exec, /home/tim/dotfiles/scripts/rofi/scripts.sh"
            "$mod, R, exec, rofi -show drun"
            "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
            "$mod, S, exec, grimblast copy area # screenshot"
            "$mod SHIFT, S, exec, ~/dotfiles/scripts/pinshot.sh"

            "$mod, Z, exit,"
            "$mod, Q, killactive,"
            "$mod, I, togglefloating,"

            "$mod, F, fullscreen, 1"
            "$mod SHIFT, F, fullscreen,"
            "$mod CTRL, F, fullscreenstate, 1"

            "$mod, O, pseudo,"
            "$mod, E, togglesplit,"

            "$mod, H, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"

            "$mod SHIFT, H, movewindow, l"
            "$mod SHIFT, J, movewindow, d"
            "$mod SHIFT, K, movewindow, u"
            "$mod SHIFT, L, movewindow, r"

            "$mod, 1, focusWorkspaceOnCurrentMonitor, 1"
            "$mod, 2, focusWorkspaceOnCurrentMonitor, 2"
            "$mod, 3, focusWorkspaceOnCurrentMonitor, 3"
            "$mod, 4, focusWorkspaceOnCurrentMonitor, 4"
            "$mod, 5, focusWorkspaceOnCurrentMonitor, 5"
            "$mod, 6, focusWorkspaceOnCurrentMonitor, 6"
            "$mod, 7, focusWorkspaceOnCurrentMonitor, 7"
            "$mod, 8, focusWorkspaceOnCurrentMonitor, 8"
            "$mod, 9, focusWorkspaceOnCurrentMonitor, 9"
            "$mod, 0, focusWorkspaceOnCurrentMonitor, 10"

            "$mod SHIFT, 1, movetoworkspacesilent, 1"
            "$mod SHIFT, 2, movetoworkspacesilent, 2"
            "$mod SHIFT, 3, movetoworkspacesilent, 3"
            "$mod SHIFT, 4, movetoworkspacesilent, 4"
            "$mod SHIFT, 5, movetoworkspacesilent, 5"
            "$mod SHIFT, 6, movetoworkspacesilent, 6"
            "$mod SHIFT, 7, movetoworkspacesilent, 7"
            "$mod SHIFT, 8, movetoworkspacesilent, 8"
            "$mod SHIFT, 9, movetoworkspacesilent, 9"
            "$mod SHIFT, 0, movetoworkspacesilent, 10"

            "$mod, Space, togglespecialworkspace, scratchpad"
            "$mod SHIFT, Space, movetoworkspacesilent, special:scratchpad"
          ];
          binde = [
            "$mod SHIFT CTRL, H, moveactive, -20 0"
            "$mod SHIFT CTRL, J, moveactive, 0 20"
            "$mod SHIFT CTRL, K, moveactive, 0 -20"
            "$mod SHIFT CTRL, L, moveactive, 20 0"

            "$mod CTRL, H, resizeactive, -20 0"
            "$mod CTRL, J, resizeactive, 0 20"
            "$mod CTRL, K, resizeactive, 0 -20"
            "$mod CTRL, L, resizeactive, 20 0"
          ];
          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}

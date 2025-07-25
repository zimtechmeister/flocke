{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager = {
    hyprland = {
      plugins = [
        inputs.hyprland-plugins.packages."${pkgs.system}".hyprbars
      ];
      settings = {
        "plugin:hyprbars" = {
          enabled = true;
          bar_color = "rgb(${config.stylix.base16Scheme.base11})";
          bar_height = 16;

          "col.text" = "rgb(${config.stylix.base16Scheme.base05})";
          bar_title_enabled = true;
          bar_text_size = config.stylix.fonts.sizes.desktop;
          bar_text_font = "${config.stylix.fonts.serif.name}";
          bar_text_align = "center";

          bar_buttons_alignment = "right";

          # draw shadow around bar?
          bar_part_of_window = true;
          # draw border around bar?
          bar_precedence_over_border = true;

          bar_padding = 8;
          bar_button_padding = 4;

          hyprbars-button = [
            "rgb(${config.stylix.base16Scheme.base08}), 12, , hyprctl dispatch killactive"
            "rgb(${config.stylix.base16Scheme.base0B}), 12, , hyprctl dispatch setfloating"
          ];
        };

        general = {
          border_size = lib.mkForce 0;
          # mkOverride 20000 higher than mkForce (10000)
          "col.active_border" = lib.mkOverride 20000 "rgb(${config.stylix.base16Scheme.base11})";
          "col.inactive_border" = lib.mkOverride 20000 "rgb(${config.stylix.base16Scheme.base11})";
        };

        windowrule = lib.mkForce [
          "suppressevent maximize, class:.*"
          "plugin:hyprbars:bar_color rgb(${config.stylix.base16Scheme.base01}), focus:1"
          "plugin:hyprbars:title_color rgb(${config.stylix.base16Scheme.base05}), focus:1"
          "plugin:hyprbars:nobar, onworkspace:w[tv1]w[fv0]"
          "noborder, onworkspace:w[tv1]w[fv0]"
          "rounding 0, onworkspace:w[tv1]w[fv0]"
        ];
        workspace = lib.mkForce [
          "special:scratchpad, gapsout:32, gapsin:4"
          "w[tv1], gapsout:0, gapsin:0"
        ];
      };
    };
  };
}

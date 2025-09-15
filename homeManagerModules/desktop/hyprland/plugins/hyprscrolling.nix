{
  inputs,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager = {
    hyprland = {
      plugins = [
        inputs.hyprland-plugins.packages."${pkgs.system}".hyprscrolling
      ];
      settings = {
        animations.enabled = lib.mkForce true;
        general.layout = lib.mkForce "scrolling";
        "plugin:hyprscrolling" = {
          fullscreen_on_one_column = true;
          column_width = 0.5;
          focus_fit_method = 1;
          bind = [
            # hyprctl dispatch layoutmsg colresize +0.25
            "SUPER SHIFT, O, layoutmsg, colresize, +0.25"
            #   "SUPER SHIFT, E, layoutmsg colresize -0.25"
          ];
        };
      };
    };
  };
}

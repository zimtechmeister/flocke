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
        general.layout = lib.mkForce "scrolling";
        "plugin:hyprscrolling" = {
          fullscreen_on_one_column = true;
          column_width = 0.5;
        };
      };
    };
  };
}

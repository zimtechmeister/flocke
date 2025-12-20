{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.hyprland.plugins.hyprscrolling.enable {
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
        };
      };
    };
  };
}

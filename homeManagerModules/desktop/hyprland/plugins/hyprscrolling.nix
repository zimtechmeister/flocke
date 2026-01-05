{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.my.hyprland.plugins.hyprscrolling.enable {
  wayland.windowManager = {
    hyprland = {
      plugins = [
        inputs.hyprland-plugins.packages."${pkgs.stdenv.hostPlatform.system}".hyprscrolling
      ];
      settings = {
        general.layout = lib.mkForce "scrolling";
        "plugin:hyprscrolling" = {
          fullscreen_on_one_column = true;
          column_width = 1.0;
          focus_fit_method = 1;
        };
      };
    };
  };
}

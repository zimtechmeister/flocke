{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options.my.hyprland.enable = lib.mkEnableOption "hyprland";
  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = false;
    };
  };
}

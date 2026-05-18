{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  options.my.hyprland.enable = lib.mkEnableOption "hyprland";
  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = false;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = self.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}

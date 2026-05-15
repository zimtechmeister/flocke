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
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.override {
        theme = {
          colors = config.lib.stylix.colors;
          fonts = {
            serif = config.stylix.fonts.serif.name;
            sansSerif = config.stylix.fonts.sansSerif.name;
            monospace = config.stylix.fonts.monospace.name;
          };
        };
      };
      portalPackage = self.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}

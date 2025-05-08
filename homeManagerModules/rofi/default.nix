{
  pkgs,
  lib,
  config,
  ...
}: let
  menu = pkgs.lib.fileContents ./scripts/menu.sh;
  power-menu = pkgs.lib.fileContents ./scripts/power-menu.sh;
in {
  options.rofi.enable = lib.mkEnableOption "enables rofi";
  config = lib.mkIf config.rofi.enable {
    xdg.configFile."rofi/config.rasi".source = ./config.rasi;
    home.packages = [
      pkgs.rofi-wayland
      pkgs.rofimoji
      (pkgs.writeShellScriptBin "menu" menu)
      (pkgs.writeShellScriptBin "power-menu" power-menu)
    ];
  };
}

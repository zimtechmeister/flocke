{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    rofi = {
      enable = lib.mkEnableOption "enables rofi";
    };
  };
  config = lib.mkIf config.rofi.enable {
    # programs.rofi = {
    #   enable = true;
    #   package = pkgs.rofi-wayland;
    # };
    xdg.configFile."rofi/config.rasi".source = ./config.rasi;
  };
}

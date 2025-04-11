{
  pkgs,
  lib,
  config,
  ...
}: {
  options.rofi.enable = lib.mkEnableOption "enables rofi";
  config = lib.mkIf config.rofi.enable {
    xdg.configFile."rofi/config.rasi".source = ./config.rasi;
  };
}

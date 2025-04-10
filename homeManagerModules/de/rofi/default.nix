{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    rofi = {
      enable = lib.mkEnableOption "enables rofi";
      config = lib.mkOption {
        # NOTE: this default might cause problems and its not the only
        # occurrence of such a problem (maybe keep null the default and only if
        # its set to something else this has effect)
        default = null;
        description = ''
          rofi config
        '';
      };
    };
  };
  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
    xdg.configFile."rofi/config.rasi".source = ./config.rasi;
  };
}

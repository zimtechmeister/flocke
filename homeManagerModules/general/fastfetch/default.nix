{
  lib,
  config,
  ...
}: {
  options.my.fastfetch.enable = lib.mkEnableOption "enables fastfetch";
  config = lib.mkIf config.my.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
    };
    xdg.configFile."fastfetch/config.jsonc".source = ./config.jsonc;
  };
}

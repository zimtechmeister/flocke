{
  lib,
  config,
  ...
}: {
  options = {
    fastfetch = {
      enable = lib.mkEnableOption "enables fastfetch";
    };
  };
  config = lib.mkIf config.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
    };
    xdg.configFile."fastfetch/config.jsonc".source = ./config.jsonc;
  };
}

{
  lib,
  config,
  ...
}: {
  options = {
    zsh.enable =
      lib.mkEnableOption "configure zsh to my liking";
  };

  config = lib.mkIf config.zsh.enable {
    home.file = {
    };
    xdg.configFile."starship.toml".source = ./starship.toml;
  };
}

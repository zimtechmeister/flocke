{
  lib,
  config,
  ...
}: {
  options.starship.enable =
    lib.mkEnableOption "configure starship";

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      # settings
    };
  };
}

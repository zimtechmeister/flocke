{
  lib,
  config,
  ...
}: {
  options.lsd.enable =
    lib.mkEnableOption "lsd";

  config = lib.mkIf config.lsd.enable {
    programs.lsd = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

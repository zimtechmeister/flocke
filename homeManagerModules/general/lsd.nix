{
  lib,
  config,
  ...
}: {
  options.my.lsd.enable = lib.mkEnableOption "lsd";
  config = lib.mkIf config.my.lsd.enable {
    programs.lsd = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}

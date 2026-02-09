{
  lib,
  config,
  ...
}: {
  options.my.yazi.enable = lib.mkEnableOption "yazi";
  config = lib.mkIf config.my.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}

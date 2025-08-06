{
  lib,
  config,
  ...
}: {
  options.yazi.enable =
    lib.mkEnableOption "yazi";

  config = lib.mkIf config.yazi.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options.my.television.enable = lib.mkEnableOption "enable television";
  config = lib.mkIf config.my.television.enable {
    programs.television = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
  };
}

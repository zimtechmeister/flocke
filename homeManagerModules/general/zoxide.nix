{
  lib,
  config,
  ...
}: {
  options.my.zoxide.enable =
    lib.mkEnableOption "zoxide";

  config = lib.mkIf config.my.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      options = [
        # use "cd" and "cdi" insead of "z" and "zi"
        "--cmd cd"
      ];
    };
  };
}

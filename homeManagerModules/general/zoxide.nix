{
  lib,
  config,
  ...
}: {
  options.zoxide.enable =
    lib.mkEnableOption "zoxide";

  config = lib.mkIf config.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        # use "cd" and "cdi" insead of "z" and "zi"
        "--cmd cd"
      ];
    };
  };
}

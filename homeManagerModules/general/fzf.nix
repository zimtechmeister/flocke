{
  lib,
  config,
  ...
}: {
  options.my.fzf.enable =
    lib.mkEnableOption "fzf";

  config = lib.mkIf config.my.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

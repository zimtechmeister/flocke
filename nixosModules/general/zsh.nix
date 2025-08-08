{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zsh.enable =
      lib.mkEnableOption "zsh nixos module";
  };
  config = lib.mkIf config.zsh.enable {
    programs = {
      zsh = {
        enable = true;
      };
    };
    users.defaultUserShell = pkgs.zsh;
  };
}

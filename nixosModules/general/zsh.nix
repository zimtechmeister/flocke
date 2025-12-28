{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.zsh.enable = lib.mkEnableOption "zsh nixos module";
  config = lib.mkIf config.my.zsh.enable {
    programs = {
      zsh = {
        enable = true;
      };
    };
    users.defaultUserShell = pkgs.zsh;
  };
}

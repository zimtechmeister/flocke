{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.shell.enable = lib.mkEnableOption "shell nixos module";
  config = lib.mkIf config.my.shell.enable {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
  };
}

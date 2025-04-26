{
  pkgs,
  lib,
  config,
  ...
}: let
  toggle-keyboard = pkgs.lib.fileContents ./toggle-keyboard.sh;
in {
  options.scripts.enable =
    lib.mkEnableOption "enables home-manager for nixBTW";

  config = lib.mkIf config.scripts.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "toggle-keyboard" toggle-keyboard)
    ];
  };
}

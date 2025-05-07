{
  pkgs,
  lib,
  config,
  ...
}: let
  toggle-keyboard = pkgs.lib.fileContents ./toggle-keyboard.sh;
  screenshot = pkgs.lib.fileContents ./screenshot.sh;
in {
  options.scripts.enable =
    lib.mkEnableOption "enables home-manager for nixBTW";

  config = lib.mkIf config.scripts.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "toggle-keyboard" toggle-keyboard)
      (pkgs.writeShellScriptBin "screenshot" screenshot)
    ];
  };
}

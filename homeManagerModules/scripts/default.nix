{
  pkgs,
  lib,
  config,
  ...
}: let
  toggle-keyboard = pkgs.lib.fileContents ./toggle-keyboard.sh;
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    grim -g "$(slurp -o -c '#${config.stylix.base16Scheme.base08}ff')" -t ppm - | satty --filename - --fullscreen --output-filename $HOME/Pictures/screenshot-$(date '+%Y%m%d-%H:%M:%S').png
  '';
in {
  options.my.scripts.enable = lib.mkEnableOption "enables home-manager for nixBTW";
  config = lib.mkIf config.my.scripts.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "toggle-keyboard" toggle-keyboard)
      screenshot
    ];
  };
}

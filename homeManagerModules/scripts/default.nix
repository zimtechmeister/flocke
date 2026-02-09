{
  pkgs,
  lib,
  config,
  ...
}: let
  toggle-keyboard = pkgs.lib.fileContents ./toggle-keyboard.sh;
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    grim -g "$(slurp -o -d -c '#00000000' -B '#88888888')" -t ppm - | satty --filename - --output-filename $HOME/Pictures/screenshot-$(date '+%Y%m%d-%H:%M:%S').png
  '';
in {
  options.my.scripts.enable = lib.mkEnableOption "enables home-manager for nixBTW";
  config = lib.mkIf config.my.scripts.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "toggle-keyboard" toggle-keyboard)

      pkgs.grim
      pkgs.slurp
      pkgs.satty
      screenshot
    ];
  };
}

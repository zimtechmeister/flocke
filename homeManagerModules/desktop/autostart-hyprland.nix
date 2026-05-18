{
  lib,
  config,
  pkgs,
  self,
  ...
}: let
  start-hyprland = lib.getExe' self.packages.${pkgs.stdenv.hostPlatform.system}.hyprland "start-hyprland";
  autostart-hyprland = pkgs.writeShellScript "autostart-hyprland" ''
    # if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    if [[ -z $DISPLAY ]] && [[ "$XDG_VTNR" = 1 ]]; then
      exec ${start-hyprland}
    fi
  '';
in {
  options.my.autostart-hyprland.enable = lib.mkEnableOption "autostart hyprland script";
  config = lib.mkIf config.my.autostart-hyprland.enable {
    programs.fish.loginShellInit = ''
      ${autostart-hyprland}
    '';
  };
}

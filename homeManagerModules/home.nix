{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  toggle-keyboard = pkgs.lib.fileContents ./toggle-keyboard.sh;
in {
  options.mongo.enable =
    lib.mkEnableOption "enables home-manager for nixBTW";

  config = lib.mkIf config.mongo.enable {
    home = {
      username = "tim";
      homeDirectory = "/home/tim";
      packages = [
        inputs.zen-browser.packages."${pkgs.system}".default

        #TODO: still need a good way how to do scripts this cant be executed form waybar!?
        (pkgs.writeShellScriptBin "toggle-keyboard" toggle-keyboard)
      ];
      stateVersion = "24.11"; # Please read the comment before changing.
    };
    # Let's Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}

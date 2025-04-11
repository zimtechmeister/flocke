{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  ...
}: let
  toggle-keyboard = pkgs.lib.fileContents ./toggle-keyboard.sh;
in {
  options = {
    mongo.enable =
      lib.mkEnableOption "enables home-manager for nixBTW";
  };

  config = lib.mkIf config.mongo.enable {
    home.username = "tim";
    home.homeDirectory = "/home/tim";

    # is this still correct for
    xdg.mimeApps.defaultApplications = {
      "text/plain" = ["neovide.desktop"];
      "image/*" = ["imv.desktop"]; # qimgv.desktop
      "video/*" = ["mpv.desktop"];
      "inode/directory" = ["pcmanfm.desktop"];
      "application/pdf" = ["zen-beta.desktop"]; # zathura.desktop
      "text/html" = ["zen-beta.desktop"];
      "x-scheme-handler/about" = ["zen-beta.desktop"];
      "x-scheme-handler/http" = ["zen-beta.desktop"];
      "x-scheme-handler/https" = ["zen-beta.desktop"];
      "x-scheme-handler/unknown" = ["zen-beta.desktop"];
      "x-scheme-handler/webcal" = ["zen-beta.desktop"];
      "x-scheme-handler/chrome" = ["zen-beta.desktop"];
    };

    home.packages = [
      inputs.zen-browser.packages."${pkgs.system}".default

      (pkgs.writeShellScriptBin "toggle-keyboard" toggle-keyboard)
    ];

    home.stateVersion = "24.11"; # Please read the comment before changing.

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}

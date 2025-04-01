{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
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
    };

    # Cursor theme
    home.pointerCursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
      gtk.enable = true;
    };
    gtk = {
      enable = true;
    };

    home.packages = [
      # seems like i need this when gtk.enable is set
      pkgs.dconf

      # TODO: look at hyprland there i use pkgs.system
      inputs.zen-browser.packages."${pkgs.system}".default

      # You can also create simple shell scripts directly inside your
      # configuration. For example, this adds a command 'my-hello' to your
      # environment:
      (pkgs.writeShellScriptBin "my-hello" ''
        echo "Hello, ${config.home.username}!"
      '')
    ];

    home.stateVersion = "24.11"; # Please read the comment before changing.

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}

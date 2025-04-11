{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cursor-theme.enable = lib.mkEnableOption "rsnte";
  config = lib.mkIf config.cursor-theme.enable {
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
      # Seems like I need this when gtk.enable is set
      pkgs.dconf
    ];
  };
}

{
  lib,
  config,
  ...
}: {
  options.my.mimeApps.enable = lib.mkEnableOption "mimeApps";
  config = lib.mkIf config.my.mimeApps.enable {
    # location of .desktop files:
    # /run/current-system/sw/share/applications
    # ~/.local/share/applications
    xdg = {
      terminal-exec = {
        enable = true;
      };
      mimeApps = {
        enable = true;
        settings = {
          default = ["ghostty.desktop"];
        };
        defaultApplications = {
          "text/*" = ["nvim.desktop"];

          "image/*" = ["qimgv.desktop" "imv.desktop"];

          "video/*" = ["mpv.desktop"];

          "inode/directory" = ["org.gnome.Nautilus.desktop"];

          "application/pdf" = ["helium.desktop" "zathura.desktop"]; # zathura.desktop
          "text/html" = ["helium.desktop"];
          "x-scheme-handler/about" = ["helium.desktop"];
          "x-scheme-handler/http" = ["helium.desktop"];
          "x-scheme-handler/https" = ["helium.desktop"];
          "x-scheme-handler/unknown" = ["helium.desktop"];
          "x-scheme-handler/webcal" = ["helium.desktop"];
          "x-scheme-handler/chrome" = ["helium.desktop"];
        };
      };
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options.mimeApps.enable = lib.mkEnableOption "mimeApps";
  config = lib.mkIf config.mimeApps.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/*" = ["neovide.desktop"];

        "image/*" = ["qimgv.desktop"]; # imv.desktop

        "video/*" = ["mpv.desktop"];

        "inode/directory" = ["pcmanfm.desktop"];

        "application/pdf" = ["firefox.desktop"]; # zathura.desktop
        "text/html" = ["firefox.desktop"];
        "x-scheme-handler/about" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "x-scheme-handler/unknown" = ["firefox.desktop"];
        "x-scheme-handler/webcal" = ["firefox.desktop"];
        "x-scheme-handler/chrome" = ["firefox.desktop"];
      };
    };
  };
}

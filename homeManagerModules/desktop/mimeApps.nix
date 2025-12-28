{
  lib,
  config,
  ...
}: {
  options.my.mimeApps.enable = lib.mkEnableOption "mimeApps";
  config = lib.mkIf config.my.mimeApps.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/*" = ["neovide.desktop"];

        "image/*" = ["qimgv.desktop"]; # imv.desktop

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
    };
  };
}

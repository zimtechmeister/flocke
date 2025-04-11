{
  lib,
  config,
  ...
}: {
  options.mimeApps.enable = lib.mkEnableOption "mimeApps";
  config = lib.mkIf config.mimeApps.enable {
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
  };
}

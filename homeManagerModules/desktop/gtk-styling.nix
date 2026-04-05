{
  lib,
  config,
  ...
}: {
  options.my.gtk-styling.enable = lib.mkEnableOption "additional gtk-styling adjustments";
  config = lib.mkIf config.my.gtk-styling.enable {
    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":";
      };
    };
  };
}

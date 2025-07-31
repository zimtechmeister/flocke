{
  lib,
  config,
  ...
}: {
  options.ghostty.enable = lib.mkEnableOption "enables ghostty";
  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        font-family = config.stylix.fonts.monospace.name;
        font-size = 12.0;
        theme = "GruvboxDark";
        cursor-color = "#${config.stylix.base16Scheme.base05}";
        window-padding-balance = true;
        window-new-tab-position = "current"; # current, end
        gtk-tabs-location = "top"; # top, bottom, left, right, hidden
        gtk-wide-tabs = true;
      };
    };
  };
}

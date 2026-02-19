{
  lib,
  config,
  ...
}: {
  options.my.ghostty.enable = lib.mkEnableOption "enables ghostty";
  config = lib.mkIf config.my.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      systemd.enable = true;
      settings = {
        cursor-color = "#${config.stylix.base16Scheme.base05}";
        window-padding-balance = true;
        window-new-tab-position = "current"; # current, end
        gtk-tabs-location = "top"; # top, bottom, left, right, hidden
        gtk-wide-tabs = true;
        keybind = [
          "ctrl+s=write_scrollback_file:open"
        ];
        shell-integration-features = "ssh-terminfo,ssh-env";
      };
    };
  };
}

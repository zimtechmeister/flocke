{
  lib,
  config,
  ...
}: {
  imports = [
    ./hyprland
    # ./niri
    ./swaync
    ./waybar
    ./firefox.nix
    ./ghostty.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpolkitagent.nix
    ./hyprsunset.nix
    ./mimeApps.nix
    ./noctalia.nix
    ./vesktop.nix
    ./vicinae.nix
    ./zen-browser.nix
  ];

  options.my.desktop.enable = lib.mkEnableOption "enables desktop home-manager config";
  config = lib.mkIf config.my.desktop.enable {
    my = {
      hyprland.enable = lib.mkDefault true;
      hyprland.plugins.hyprscrolling.enable = lib.mkDefault false;
      # niri.enable = lib.mkDefault false;
      swaync.enable = lib.mkDefault false;
      waybar.enable = lib.mkDefault false;
      firefox.enable = lib.mkDefault false;
      ghostty.enable = lib.mkDefault true;
      hypridle.enable = lib.mkDefault true;
      hyprlock.enable = lib.mkDefault false;
      hyprpaper.enable = lib.mkDefault false;
      hyprpolkitagent.enable = lib.mkDefault true;
      hyprsunset.enable = lib.mkDefault false;
      mimeApps.enable = lib.mkDefault true;
      noctalia.enable = lib.mkDefault true;
      vesktop.enable = lib.mkDefault true;
      vicinae.enable = lib.mkDefault true;
      zen-browser.enable = lib.mkDefault true;
    };
  };
}

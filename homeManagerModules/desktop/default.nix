{
  lib,
  config,
  ...
}: {
  imports = [
    ./ghostty
    ./hypridle
    ./hyprland
    ./hyprlock
    ./hyprpaper
    ./hyprpolkitagent
    ./niri
    ./rofi
    ./swaync
    ./waybar
    ./mimeApps.nix
    ./vesktop.nix
    ./zen-browser.nix
  ];

  options.desktop.enable =
    lib.mkEnableOption "enables desktop home-manager config";

  config = lib.mkIf config.desktop.enable {
    ghostty.enable = lib.mkDefault true;
    hypridle.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    hyprlock.enable = lib.mkDefault true;
    hyprpolkitagent.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    swaync.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    mimeApps.enable = lib.mkDefault true;
    vesktop.enable = lib.mkDefault true;
    zen-browser.enable = lib.mkDefault true;

    # swapped out for stylix
    hyprpaper.enable = lib.mkDefault false;
    niri.enable = lib.mkDefault false;
  };
}

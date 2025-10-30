{
  lib,
  config,
  ...
}: {
  imports = [
    ./hyprland
    # ./niri
    ./swaync
    ./walker
    ./waybar
    ./firefox.nix
    ./ghostty.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpolkitagent.nix
    ./hyprsunset.nix
    ./mimeApps.nix
    ./vesktop.nix
    ./zen-browser.nix
  ];

  options.desktop.enable =
    lib.mkEnableOption "enables desktop home-manager config";

  config = lib.mkIf config.desktop.enable {
    hyprland.enable = lib.mkDefault true;
    # niri.enable = lib.mkDefault false;
    swaync.enable = lib.mkDefault true;
    walker.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    ghostty.enable = lib.mkDefault true;
    hypridle.enable = lib.mkDefault true;
    hyprlock.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    hyprpolkitagent.enable = lib.mkDefault true;
    hyprsunset.enable = lib.mkDefault true;
    mimeApps.enable = lib.mkDefault true;
    vesktop.enable = lib.mkDefault true;
    zen-browser.enable = lib.mkDefault false;
  };
}

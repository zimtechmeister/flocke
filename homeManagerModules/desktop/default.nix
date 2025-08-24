{
  lib,
  config,
  ...
}: {
  imports = [
    ./anyrun
    ./hyprland
    ./niri
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
    ./vesktop.nix
    ./zen-browser.nix

    # ./walker.nix
  ];

  options.desktop.enable =
    lib.mkEnableOption "enables desktop home-manager config";

  config = lib.mkIf config.desktop.enable {
    anyrun.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    niri.enable = lib.mkDefault true;
    swaync.enable = lib.mkDefault true;
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
    zen-browser.enable = lib.mkDefault true;
  };
}

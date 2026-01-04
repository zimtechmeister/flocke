{
  lib,
  config,
  ...
}: {
  imports = [
    ./dankMaterialShell
    ./hyprland
    # ./niri
    ./swaync
    # ./walker
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
    ./vicinae.nix
    ./zen-browser.nix
  ];

  options.my.desktop.enable = lib.mkEnableOption "enables desktop home-manager config";
  config = lib.mkIf config.my.desktop.enable {
    my = {
      dankMaterialShell.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      hyprland.plugins.hyprscrolling.enable = lib.mkDefault true;
      # niri.enable = lib.mkDefault false;
      swaync.enable = lib.mkDefault false;
      # walker.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault false;
      firefox.enable = lib.mkDefault true;
      ghostty.enable = lib.mkDefault true;
      hypridle.enable = lib.mkDefault false;
      hyprlock.enable = lib.mkDefault false;
      hyprpaper.enable = lib.mkDefault false;
      hyprpolkitagent.enable = lib.mkDefault true;
      hyprsunset.enable = lib.mkDefault false;
      mimeApps.enable = lib.mkDefault true;
      vesktop.enable = lib.mkDefault true;
      vicinae.enable = lib.mkDefault true;
      zen-browser.enable = lib.mkDefault true;
    };
  };
}

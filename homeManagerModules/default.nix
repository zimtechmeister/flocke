{lib, pkgs, inputs, ...}: {
  imports = [
    ./home.nix

    ./zsh
    ./git.nix
    ./hyprland
    ./hypridle
    ./hyprlock
    ./hyprpaper
    ./waybar
    ./swaync
    ./rofi
    ./ghostty
    ./fastfetch
    ./cursor-theme.nix
    ./mimeApps.nix
  ];

  mongo.enable = lib.mkDefault true;

  zsh.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  hyprpaper.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
  swaync.enable = lib.mkDefault true;
  rofi.enable = lib.mkDefault true;
  ghostty.enable = lib.mkDefault true;
  fastfetch.enable = lib.mkDefault true;
  cursor-theme.enable = lib.mkDefault true;
  mimeApps.enable = lib.mkDefault true;

  # TODO: dont do this here and use ${system} instead of x86_64-linux
  # maybe even install for root
  # also change the environment variables
  home.packages = [
    inputs.nixcats.packages.x86_64-linux.default
  ];
}

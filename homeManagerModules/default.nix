{lib, ...}: {
  imports = [
    ./home.nix

    ./zsh
    ./swaync
    ./hyprland
    ./waybar
    ./rofi
    ./ghostty
    ./hypridle
    ./hyprlock
    ./hyprpaper
  ];

  mongo.enable =
    lib.mkDefault true;

  zsh.enable =
    lib.mkDefault true;
  hyprland.enable =
    lib.mkDefault true;
  swaync.enable =
    lib.mkDefault true;
  waybar.enable =
    lib.mkDefault true;
  rofi.enable =
    lib.mkDefault true;
  ghostty.enable =
    lib.mkDefault true;
  hypridle.enable =
    lib.mkDefault true;
  hyprlock.enable =
    lib.mkDefault true;
  hyprpaper.enable =
    lib.mkDefault true;
}

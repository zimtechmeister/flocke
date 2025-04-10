{lib, ...}: {
  imports = [
    ./home.nix

    ./zsh
    ./swaync
    ./hyprland
    ./waybar
    ./rofi
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
}

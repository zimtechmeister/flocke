{
  lib,
  config,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./fonts.nix
    ./gaming.nix
    ./hyprland.nix
    ./localsend.nix
    ./packages.nix
  ];

  options.desktop.enable = lib.mkEnableOption "enables desktop nixos-module";

  config = lib.mkIf config.desktop.enable {
    bluetooth.enable = lib.mkDefault false;
    fonts.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
    localsend.enable = lib.mkDefault true;
    desktop-packages.enable = lib.mkDefault true;
  };
}

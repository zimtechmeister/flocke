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
    ./laptop.nix
    ./localsend.nix
    ./packages.nix
  ];

  options.my.desktop.enable = lib.mkEnableOption "enables desktop nixos-module";
  config = lib.mkIf config.my.desktop.enable {
    my = {
      bluetooth.enable = lib.mkDefault false;
      fonts.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault false;
      hyprland.enable = lib.mkDefault true;
      laptop.enable = lib.mkDefault false;
      localsend.enable = lib.mkDefault true;
      desktop-packages.enable = lib.mkDefault true;
    };
  };
}

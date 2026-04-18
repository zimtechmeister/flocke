{
  lib,
  config,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./evolution-data-server.nix
    ./fonts.nix
    ./gaming.nix
    ./hyprland.nix
    ./laptop.nix
    ./localsend.nix
    ./packages.nix
    ./virt-manager.nix
  ];

  options.my.desktop.enable = lib.mkEnableOption "enables desktop nixos-module";
  config = lib.mkIf config.my.desktop.enable {
    my = {
      bluetooth.enable = lib.mkDefault false;
      evolution-data-server.enable = lib.mkDefault true;
      fonts.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault false;
      hyprland.enable = lib.mkDefault true;
      laptop.enable = lib.mkDefault false;
      localsend.enable = lib.mkDefault true;
      desktop-packages.enable = lib.mkDefault true;
      virt-manager.enable = lib.mkDefault true;
    };
  };
}

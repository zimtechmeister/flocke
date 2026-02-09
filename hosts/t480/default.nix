{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "t480";

  my = {
    desktop.enable = lib.mkForce true;
    laptop.enable = lib.mkForce true;
    bluetooth.enable = lib.mkForce true;
  };

  home-manager.users.tim.my = {
    desktop.enable = lib.mkForce true;
    general.enable = lib.mkForce true;
    scripts.enable = lib.mkForce true;

    hyprland.monitorLayout = lib.mkDefault "t480";
  };
}

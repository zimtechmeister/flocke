{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  desktop.enable = lib.mkForce true;
  bluetooth.enable = lib.mkForce true;

  networking.hostName = "t480";
}

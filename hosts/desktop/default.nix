{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  desktop.enable = lib.mkForce true;
  gaming.enable = lib.mkForce true;

  networking.hostName = "desktop";
}

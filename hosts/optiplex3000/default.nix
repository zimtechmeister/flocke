{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  desktop.enable = lib.mkForce false;
  bluetooth.enable = lib.mkForce false;
  server.enable = lib.mkForce true;

  networking.hostName = "optiplex3000";
}

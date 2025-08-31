{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # TODO: can do this in flake.nix
  desktop.enable = lib.mkForce true;
  gaming.enable = lib.mkForce true;

  # NOTE: this is the only option that should be left in this file?
  networking.hostName = "desktop";

  # TODO: do this in nixosModules/default.nix
  system.stateVersion = "24.11";
}

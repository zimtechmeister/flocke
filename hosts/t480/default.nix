{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  desktop.enable = lib.mkForce true;
  bluetooth.enable = lib.mkForce true;

  networking.hostName = "t480";

  home-manager.users.tim = {
    desktop.enable = lib.mkForce true;
    general.enable = lib.mkForce true;
    scripts.enable = lib.mkForce true;

    hyprland.monitorLayout = lib.mkDefault "t480";
    waybar.config = lib.mkDefault "t480";
  };
}

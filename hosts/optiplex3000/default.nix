{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  desktop.enable = lib.mkForce false;
  bluetooth.enable = lib.mkForce false;
  server.enable = lib.mkForce true;

  networking.hostName = "optiplex3000";

  home-manager.users.tim = {
    desktop.enable = lib.mkForce false;
    general.enable = lib.mkForce true;
    scripts.enable = lib.mkForce false;

    hyprland.monitorLayout = lib.mkDefault "optiplex3000";
    waybar.config = lib.mkDefault "optiplex3000";
  };
}

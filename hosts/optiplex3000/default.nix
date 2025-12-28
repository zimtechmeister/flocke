{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  networking.hostName = "optiplex3000";

  my = {
    desktop.enable = lib.mkForce false;
    bluetooth.enable = lib.mkForce false;
    server.enable = lib.mkForce true;
  };

  home-manager.users.tim.my = {
    desktop.enable = lib.mkForce false;
    general.enable = lib.mkForce true;
    scripts.enable = lib.mkForce false;

    hyprland.monitorLayout = lib.mkDefault "optiplex3000";
    waybar.config = lib.mkDefault "optiplex3000";
  };
}

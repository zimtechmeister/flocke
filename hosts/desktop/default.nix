{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  networking.hostName = "desktop";

  my = {
    desktop.enable = lib.mkForce true;
    gaming.enable = lib.mkForce true;
  };

  home-manager.users.tim.my = {
    desktop.enable = lib.mkForce true;
    general.enable = lib.mkForce true;
    scripts.enable = lib.mkForce true;

    hyprland.monitorLayout = lib.mkDefault "desktop";
    waybar.config = lib.mkDefault "desktop";
  };
}

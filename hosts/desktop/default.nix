{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  desktop.enable = lib.mkForce true;
  gaming.enable = lib.mkForce true;

  networking.hostName = "desktop";

  home-manager.users.tim = {
    desktop.enable = lib.mkForce true;
    general.enable = lib.mkForce true;
    scripts.enable = lib.mkForce true;

    hyprland.monitorLayout = lib.mkDefault "desktop";
    waybar.config = lib.mkDefault "desktop";
  };
}

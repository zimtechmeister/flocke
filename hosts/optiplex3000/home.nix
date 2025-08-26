{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];

  desktop.enable = lib.mkForce false;
  general.enable = lib.mkForce true;
  scripts.enable = lib.mkForce false;

  hyprland.monitorLayout = lib.mkDefault "optiplex3000";
  waybar.config = lib.mkDefault "optiplex3000";
}

{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];

  desktop.enable = lib.mkForce true;
  general.enable = lib.mkForce true;
  scripts.enable = lib.mkForce true;

  hyprland.monitorLayout = lib.mkDefault "optiplex3000";
  waybar.config = lib.mkDefault "optiplex3000";
}

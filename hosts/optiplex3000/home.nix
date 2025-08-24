{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];

  desktop.enable = lib.mkDefault true;
  general.enable = lib.mkDefault true;
  scripts.enable = lib.mkDefault true;

  hyprland.monitorLayout = lib.mkDefault "optiplex3000";
  waybar.config = lib.mkDefault "optiplex3000";
}

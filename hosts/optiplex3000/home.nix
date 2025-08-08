{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];
  hyprland.monitorLayout = lib.mkDefault "optiplex3000";
  waybar.config = lib.mkDefault "optiplex3000";
}

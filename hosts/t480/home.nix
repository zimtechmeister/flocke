{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];
  desktop.enable = lib.mkForce true;

  hyprland.monitorLayout = lib.mkDefault "t480";
  waybar.config = lib.mkDefault "t480";
}

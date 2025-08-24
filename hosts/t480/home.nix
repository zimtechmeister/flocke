{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];
  desktop.enable = lib.mkDefault true;
  general.enable = lib.mkDefault true;
  scripts.enable = lib.mkDefault true;

  hyprland.monitorLayout = lib.mkDefault "t480";
  waybar.config = lib.mkDefault "t480";
}

{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];
  hyprland.monitorLayout =
    lib.mkDefault "t480";
  waybar.config =
    lib.mkDefault "t480";
}

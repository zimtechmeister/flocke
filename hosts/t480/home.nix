{lib, ...}: {
  desktop.enable = lib.mkForce false;
  general.enable = lib.mkForce true;
  scripts.enable = lib.mkForce true;

  hyprland.monitorLayout = lib.mkDefault "t480";
  waybar.config = lib.mkDefault "t480";
}

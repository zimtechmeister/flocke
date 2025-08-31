{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];
  #TODO: you could set thoes options in flake.nix
  desktop.enable = lib.mkForce true;
  general.enable = lib.mkForce true;
  scripts.enable = lib.mkForce true;

  hyprland.monitorLayout = lib.mkDefault "desktop";
  waybar.config = lib.mkDefault "desktop";
}

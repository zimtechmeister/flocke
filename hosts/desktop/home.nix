{lib, ...}: {
  imports = [
    ../../homeManagerModules
  ];
  #TODO: set some variables to define this in homeManagerModules/default.nix later
  # then you can import homeManagerModules in the flake file this way you dont need this file anymore
  desktop.enable = lib.mkForce true;
  general.enable = lib.mkForce true;
  scripts.enable = lib.mkForce true;

  hyprland.monitorLayout = lib.mkDefault "desktop";
  waybar.config = lib.mkDefault "desktop";
}

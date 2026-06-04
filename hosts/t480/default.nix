{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot.loader.limine = {
    secureBoot.autoEnrollKeys.extraArgs = [
      "--microsoft"
      "--ignore-immutable"
    ];
  };

  my = {
    desktop.enable = lib.mkForce true;
    laptop.enable = lib.mkForce true;
    kanata.enable = lib.mkForce true;
    bluetooth.enable = lib.mkForce true;
  };

  home-manager.users.tim.my = {
    desktop.enable = lib.mkForce true;
    general.enable = lib.mkForce true;
  };
}

{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
  ];

  boot.loader.limine = {
    extraEntries = ''
      /Windows 11
      protocol: efi
      path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';
    secureBoot.autoEnrollKeys.extraArgs = [
      "--microsoft"
      "--firmware-builtin"
    ];
  };

  my = {
    desktop.enable = lib.mkForce true;
    gaming.enable = lib.mkForce true;
  };

  home-manager.users.tim.my = {
    desktop.enable = lib.mkForce true;
    general.enable = lib.mkForce true;
  };
}

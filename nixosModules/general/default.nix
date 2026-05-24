{
  lib,
  config,
  ...
}: {
  imports = [
    ./fwupd.nix
    ./kanata.nix
    ./nix.nix
    ./nvim.nix
    ./ssh.nix
    ./shell.nix
    ./packages.nix
    ./television.nix
    ./zram.nix
  ];

  options.my.general.enable = lib.mkEnableOption "enables general nixos-module";
  config = lib.mkIf config.my.general.enable {
    my = {
      fwupd.enable = lib.mkDefault true;
      kanata.enable = lib.mkDefault false;
      nix.enable = lib.mkDefault true;
      nvim.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
      shell.enable = lib.mkDefault true;
      general-packages.enable = lib.mkDefault true;
      television.enable = lib.mkDefault true;
      zram.enable = lib.mkDefault true;
    };
  };
}

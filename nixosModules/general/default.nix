{
  lib,
  config,
  ...
}: {
  imports = [
    ./kanata.nix
    ./nix.nix
    ./openssh.nix
    ./shell.nix
    ./packages.nix
    ./zram.nix
  ];

  options.my.general.enable = lib.mkEnableOption "enables general nixos-module";
  config = lib.mkIf config.my.general.enable {
    my = {
      nix.enable = lib.mkDefault true;
      openssh.enable = lib.mkDefault true;
      shell.enable = lib.mkDefault true;
      general-packages.enable = lib.mkDefault true;
      zram.enable = lib.mkDefault true;
    };
  };
}

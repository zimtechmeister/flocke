{
  lib,
  config,
  ...
}: {
  imports = [
    ./kanata.nix
    ./maintainance.nix
    ./openssh.nix
    ./zsh.nix
    ./packages.nix
  ];

  options.my.general.enable = lib.mkEnableOption "enables general nixos-module";
  config = lib.mkIf config.my.general.enable {
    my = {
      kanata.enable = lib.mkDefault true;
      maintainance.enable = lib.mkDefault true;
      openssh.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
      general-packages.enable = lib.mkDefault true;
    };
  };
}

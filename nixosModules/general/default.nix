{
  lib,
  config,
  ...
}: {
  imports = [
    ./maintainance.nix
    ./openssh.nix
    ./zsh.nix
    ./packages.nix
  ];

  options.general.enable = lib.mkEnableOption "enables general nixos-module";

  config = lib.mkIf config.general.enable {
    maintainance.enable = lib.mkDefault true;
    openssh.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    general-packages.enable = lib.mkDefault true;
  };
}

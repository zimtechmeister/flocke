{
  lib,
  config,
  ...
}: {
  imports = [
    ./nh.nix
    ./zsh.nix
    ./packages.nix
  ];

  options.general.enable = lib.mkEnableOption "enables general nixos-module";

  config = lib.mkIf config.general.enable {
    nh.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    general-packages.enable = lib.mkDefault true;
  };
}

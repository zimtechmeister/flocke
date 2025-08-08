{lib, ...}: {
  imports = [
    ./desktop
    ./general

    ./cachix.nix
    ./stylix.nix
  ];

  config = {
    desktop.enable = lib.mkDefault true;
    general.enable = lib.mkDefault true;

    # TODO: maybe do this somewhere else
    nixpkgs.config.allowUnfree = true;
  };
}

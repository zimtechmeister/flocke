{lib, ...}: {
  imports = [
    ./features/bluetooth.nix
    ./packages/myfont.nix
    ./packages/mypackages.nix
    ./cachix.nix
    ./gaming.nix
    ./stylix.nix
  ];

  mypackages.enable = lib.mkDefault true;

  # TODO: maybe do this somewhere else
  nixpkgs.config.allowUnfree = true;
}

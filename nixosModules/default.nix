{lib, ...}: {
  imports = [
    ./cachix.nix
    ./packages/mypackages.nix
    ./packages/myfont.nix
    ./features/bluetooth.nix
    ./gaming.nix
    ./stylix.nix
  ];

  mypackages.enable = lib.mkDefault true;

  # maybe do this somewhere else
  nixpkgs.config.allowUnfree = true;
}

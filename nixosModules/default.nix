{lib, ...}: {
  imports = [
    ./cachix.nix
    ./packages/mypackages.nix
    ./packages/myfont.nix
    ./features/bluetooth.nix
    ./gaming.nix
  ];

  mypackages.enable =
    lib.mkDefault true;

  nixpkgs.config.allowUnfree = true;
}

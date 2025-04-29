{lib, ...}: {
  imports = [
    ./packages/mypackages.nix
    ./features/bluetooth.nix
  ];

  mypackages.enable =
    lib.mkDefault true;

  nixpkgs.config.allowUnfree = true;
}

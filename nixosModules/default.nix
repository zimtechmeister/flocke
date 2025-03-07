{lib, ...}: {
  imports = [
    ./packages/mypackages.nix # mypackages
  ];

  mypackages.enable =
    lib.mkDefault true;
}

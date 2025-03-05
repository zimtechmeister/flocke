{lib, ...}: {
  imports = [
    ./packages/nixBTW.nix # mypackages
  ];

  mypackages.enable =
    lib.mkDefault true;
}

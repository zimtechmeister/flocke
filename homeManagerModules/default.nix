{lib, ...}: {
  imports = [
    ./cli/home.nix
    ./de
  ];
  mongo.enable =
    lib.mkDefault true;
  de.enable =
    lib.mkDefault true;
}

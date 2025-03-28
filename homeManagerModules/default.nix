{lib, ...}: {
  imports = [
    ./cli/home.nix
    ./cli
    ./de
  ];

  mongo.enable =
    lib.mkDefault true;
  de.enable =
    lib.mkDefault true;
}

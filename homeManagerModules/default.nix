{lib, ...}: {
  imports = [
    ./cli/home.nix
    ./cli
    ./de
  ];

  home.username = "tim";
  home.homeDirectory = "/home/tim";

  mongo.enable =
    lib.mkDefault true;
  de.enable =
    lib.mkDefault true;
}

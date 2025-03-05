{lib, ...}: {
  imports = [
    ./cli/home.nix
  ];
  # mongo.enable =
  #   lib.mkDefault true;
}

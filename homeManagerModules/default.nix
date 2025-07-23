{lib, ...}: {
  imports = [
    ./home.nix

    ./desktop
    ./general
    ./scripts
  ];

  config = {
    mongo.enable = lib.mkDefault true;

    desktop.enable = lib.mkDefault true;
    general.enable = lib.mkDefault true;
    scripts.enable = lib.mkDefault true;
  };
}

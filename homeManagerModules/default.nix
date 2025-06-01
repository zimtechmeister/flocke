{lib, ...}: {
  imports = [
    ./home.nix

    ./desktop
    ./general
    ./scripts
  ];

  # NOTE: can do this with stylix
  options.systemFont = lib.mkOption {
    default = "Maple Mono NF";
    description = ''
      default system font
    '';
  };

  config = {
    mongo.enable = lib.mkDefault true;

    desktop.enable = lib.mkDefault true;
    general.enable = lib.mkDefault true;
    scripts.enable = lib.mkDefault true;
  };
}

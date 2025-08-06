{lib, ...}: {
  imports = [
    ./desktop
    ./general
    ./scripts
  ];

  config = {
    desktop.enable = lib.mkDefault true;
    general.enable = lib.mkDefault true;
    scripts.enable = lib.mkDefault true;

    home = {
      username = "tim";
      homeDirectory = "/home/tim";

      stateVersion = "24.11"; # dont change
    };
    # Let's Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}

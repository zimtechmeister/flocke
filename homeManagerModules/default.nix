{lib, ...}: {
  imports = [
    ./desktop
    ./general
    ./scripts
  ];

  my = {
    desktop.enable = lib.mkDefault false;
    general.enable = lib.mkDefault true;
    scripts.enable = lib.mkDefault false;
  };

  home = {
    username = "tim";
    homeDirectory = "/home/tim";

    stateVersion = "26.05";
  };
  # Let's Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

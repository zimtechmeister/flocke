{lib, ...}: {
  imports = [
    ./desktop
    ./general
  ];

  my = {
    desktop.enable = lib.mkDefault false;
    general.enable = lib.mkDefault true;
  };

  home = {
    username = "tim";
    homeDirectory = "/home/tim";

    stateVersion = "26.05";
  };
  # Let's Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

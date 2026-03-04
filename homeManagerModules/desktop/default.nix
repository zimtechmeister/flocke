{
  lib,
  config,
  ...
}: {
  imports = [
    ./hyprland
    # ./niri
    ./firefox.nix
    ./ghostty.nix
    ./hyprpolkitagent.nix
    ./mimeApps.nix
    ./noctalia.nix
    ./vesktop.nix
    ./zen-browser.nix
  ];

  options.my.desktop.enable = lib.mkEnableOption "enables desktop home-manager config";
  config = lib.mkIf config.my.desktop.enable {
    my = {
      hyprland.enable = lib.mkDefault true;
      # niri.enable = lib.mkDefault false;
      firefox.enable = lib.mkDefault false;
      ghostty.enable = lib.mkDefault true;
      hyprpolkitagent.enable = lib.mkDefault true;
      mimeApps.enable = lib.mkDefault true;
      noctalia.enable = lib.mkDefault true;
      vesktop.enable = lib.mkDefault true;
      zen-browser.enable = lib.mkDefault true;
    };
  };
}

{
  lib,
  types,
  ...
}: {
  imports = [
    ./home.nix

    ./zsh
    ./git.nix
    ./niri
    ./hyprland
    ./hypridle
    ./hyprlock
    ./hyprpaper
    ./waybar
    ./swaync
    ./rofi
    ./ghostty
    ./fastfetch
    ./scripts
    ./zen-browser.nix
    ./nvim.nix
    ./cursor-theme.nix
    ./mimeApps.nix
  ];

  # NOTE: maybe set this in fonts file or in extra options file
  options.systemFont = lib.mkOption {
    default = "Maple Mono NF";
    description = ''
      default system font
    '';
  };

  config = {
    mongo.enable = lib.mkDefault true;

    zsh.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    niri.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
    hypridle.enable = lib.mkDefault true;
    hyprlock.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    swaync.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    ghostty.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
    scripts.enable = lib.mkDefault true;
    zen-browser.enable = lib.mkDefault true;
    nvim.enable = lib.mkDefault true;
    cursor-theme.enable = lib.mkDefault true;
    mimeApps.enable = lib.mkDefault true;
  };
}

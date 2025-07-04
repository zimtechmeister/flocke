{
  lib,
  config,
  ...
}: {
  imports = [
    ./fastfetch
    ./starship
    ./zsh
    ./git.nix
    ./neovide.nix
    ./nvim.nix
    ./tmux.nix
  ];

  options.general.enable =
    lib.mkEnableOption "enables general home-manager config";

  config = lib.mkIf config.general.enable {
    fastfetch.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    neovide.enable = lib.mkDefault true;
    nvim.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
  };
}

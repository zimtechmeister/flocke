{
  lib,
  config,
  ...
}: {
  imports = [
    ./fastfetch
    ./fzf.nix
    ./git.nix
    ./lsd.nix
    ./neovide.nix
    ./nvim.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options.my.general.enable = lib.mkEnableOption "enables general home-manager config";
  config = lib.mkIf config.my.general.enable {
    my = {
      fastfetch.enable = lib.mkDefault true;
      fzf.enable = lib.mkDefault true;
      lsd.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      neovide.enable = lib.mkDefault true;
      nvim.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault false;
      yazi.enable = lib.mkDefault true;
      zoxide.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };
  };
}

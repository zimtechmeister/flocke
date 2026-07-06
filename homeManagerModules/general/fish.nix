{
  lib,
  config,
  pkgs,
  self,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  options.my.fish.enable = lib.mkEnableOption "configure fish";
  config = lib.mkIf config.my.fish.enable {
    programs.carapace = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.nix-index-database.comma.enable = true;

    # programs.command-not-found = {
    #   enable = true;
    # };
    # TODO: selfhost?
    # programs.atuin = {
    #   enable = true;
    #   enableFishIntegration = true;
    #   daemon.enable = true;
    # };

    programs.fish = {
      enable = true;

      shellAliases = {
        grep = "grep -i --color=auto";
        mv = "mv -i";
        cp = "cp -i";
        ls = lib.mkForce "lsd -lhAg --group-dirs first --header";
        lg = "lazygit";
      };

      interactiveShellInit = ''
        set -g fish_greeting
        fish_vi_key_bindings

        # carapace
        set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
        carapace _carapace | source
      '';
    };
  };
}

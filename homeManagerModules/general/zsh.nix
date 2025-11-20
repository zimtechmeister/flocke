{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  options.zsh.enable =
    lib.mkEnableOption "configure zsh to my liking";

  config = lib.mkIf config.zsh.enable {
    programs.carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    # TODO: selfhost?
    # programs.atuin = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   daemon = {
    #     enable = true;
    #   };
    # };
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      # enableCompletion = true;
      syntaxHighlighting.enable = true;
      history = {
        ignorePatterns = [
          "ls*"
          "cd*"
          "pwd*"
          "exit"
        ];
        append = true;
        ignoreDups = true;
      };

      shellAliases = {
        grep = "grep -i --color=auto";
        mv = "mv -i";
        cp = "cp -i";
        ls = lib.mkForce "lsd -lhAg --group-dirs first --header";
      };

      initContent = let
        mynvim = inputs.neovix.packages.${pkgs.system}.default;
      in
        /*
        sh
        */
        ''
          unsetopt beep

          # yazi shell wrapper
          function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
          }

          # carapace
          export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
          zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
          source <(carapace _carapace)

          # avoid nested nvim instances
          # TODO: if editor is set to nvim and this function is called nvim git commit will execute this
          # then git waits till the process exits (how can i do this without exiting the whole nvim instance?)
          vi() {
            if [ -n "$NVIM" ]; then
              ${mynvim}/bin/nvim --server "$NVIM" --remote "$@"
            else
              ${mynvim}/bin/nvim "$@"
            fi
          }

          # in vi normal mode press ctrl v to edit command in $EDITOR
          autoload -U edit-command-line
          zle -N edit-command-line
          bindkey -M vicmd ^v edit-command-line

          # completions show hidden files
          setopt globdots
        '';
    };
  };
}

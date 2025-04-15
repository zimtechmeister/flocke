{
  lib,
  config,
  ...
}: {
  options.zsh.enable =
    lib.mkEnableOption "configure zsh to my liking";

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
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
        ls = "lsd -lhA --group-dirs first --header";
        thm = "~/dotfiles/scripts/thm-vpn.sh";
        kssh = "kitty +kitten ssh";
      };

      initExtra =
        /*
        sh
        */
        ''
          # Path NOTE: this should be done differently
          export PATH="$PATH:$HOME/.bin"
          export PATH="$PATH:$HOME/.local/bin"

          unsetopt beep

          # Plugins and Configurations
          # source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
          #
          # source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
          #
          # source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          #
          # source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

          # yazi shell wrapper
          function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
          }

          # shell integrations
          eval "$(starship init zsh)"
          eval "$(fzf --zsh)"
          eval "$(zoxide init zsh)"  # change command (zoxide init --cmd cd zsh)

          # fzf-tab config
          # disable sort when completing `git checkout`
          zstyle ':completion:*:git-checkout:*' sort false
          # set descriptions format to enable group support
          # NOTE: don't use escape sequences here, fzf-tab will ignore them
          zstyle ':completion:*:descriptions' format '[%d]'
          # set list-colors to enable filename colorizing
          #NOTE: look in dotfle repo for line that was here but somehow does not work
          # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
          zstyle ':completion:*' menu no
          # preview directory's content with lsd when completing cd
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1A --color=always $realpath'
          #zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
          # switch group using `<` and `>`
          zstyle ':fzf-tab:*' switch-group '<' '>'
          # for the usage in tmux
          zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
          # completions show hidden files
          setopt globdots
        '';

      plugins = [
        # { name = "zsh-autosuggestions"; }
        # { name = "zsh-syntax-highlighting"; }
        # { name = "zsh-vi-mode"; }
        # { name = "fzf-tab-git"; }
      ];
    };
    #TODO: maybe do this the nix way
    xdg.configFile."starship.toml".source = ./starship.toml;
  };
}

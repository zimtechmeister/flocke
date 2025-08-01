{
  lib,
  config,
  ...
}: {
  options.zsh.enable =
    lib.mkEnableOption "configure zsh to my liking";

  config = lib.mkIf config.zsh.enable {
    # programs.zoxide.enableZshIntegration
    # programs.yazi.enableZshIntegration
    # programs.ghostty.enableZshIntegration
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      loginExtra = ''
        # if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        if [[ -z $DISPLAY ]] && [[ "$XDG_VTNR" = 1 ]]; then
          # exec Hyprland
          # reccomended way to start hyprland
          # exec uwsm start hyprland.desktop
          # TODO: how can i autostart niri?
          # exec niri-session
        fi
      '';
      # profileExtra
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
        kssh = "kitty +kitten ssh";
      };

      initContent =
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

          # in vi normal mode press v to edit command in $EDITOR
          autoload -U edit-command-line
          zle -N edit-command-line
          bindkey -M vicmd v edit-command-line

          # shell integrations
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
  };
}

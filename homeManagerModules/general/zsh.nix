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
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      loginExtra = ''
        # if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        if [[ -z $DISPLAY ]] && [[ "$XDG_VTNR" = 1 ]]; then
          exec Hyprland
          # reccomended way to start hyprland
          # exec uwsm start hyprland.desktop
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
        ls = lib.mkForce "lsd -lhA --group-dirs first --header";
      };

      initContent =
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

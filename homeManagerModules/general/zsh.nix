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
          mux() {
            # Check if arguments (files) were provided
            if [ -n "$1" ]; then
              # CASE 1: Files provided (e.g., 'mux test.lua')
              if [ -n "$NVIM" ]; then
                # Inside Neovim: Tell parent to open the file(s)
                ${mynvim}/bin/nvim --server "$NVIM" --remote "$@"
              else
                # Outside Neovim: Open normally
                ${mynvim}/bin/nvim "$@"
              fi
            else
              # CASE 2: No arguments provided (just typed 'mux')
              if [ -n "$NVIM" ]; then
                # Inside Neovim: Tell parent to open a NEW terminal split
                # <C-\><C-n> ensures we exit insert mode first
                # :vsplit | terminal -> opens terminal in vertical split
                ${mynvim}/bin/nvim --server "$NVIM" --remote-send "<C-\><C-n>:terminal<CR>i"
              else
                # Outside Neovim: Start nvim directly in terminal mode
                ${mynvim}/bin/nvim -c "terminal"
              fi
            fi
          }

          # update nvim cwd
          cvd() {
            if [ -n "$NVIM" ]; then
              ${mynvim}/bin/nvim --server "$NVIM" --remote-send "<C-\><C-n>:cd $(pwd)<CR>i"
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

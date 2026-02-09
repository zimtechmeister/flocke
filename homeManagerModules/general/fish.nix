{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  options.my.fish.enable = lib.mkEnableOption "configure fish to my liking";
  config = lib.mkIf config.my.fish.enable {
    programs.carapace = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;

      shellAliases = {
        grep = "grep -i --color=auto";
        mv = "mv -i";
        cp = "cp -i";
        ls = lib.mkForce "lsd -lhAg --group-dirs first --header";
      };

      functions = {
        # yazi shell wrapper
        y = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';

        # avoid nested nvim instances
        mux = let
          mynvim = self.packages.${pkgs.stdenv.hostPlatform.system}.neovix;
        in ''
          # Check if arguments (files) were provided
          if test -n "$argv[1]"
            # CASE 1: Files provided (e.g., 'mux test.lua')
            if test -n "$NVIM"
              # Inside Neovim: Tell parent to open the file(s)
              ${mynvim}/bin/nvim --server "$NVIM" --remote $argv
            else
              # Outside Neovim: Open normally
              ${mynvim}/bin/nvim $argv
            end
          else
            # CASE 2: No arguments provided (just typed 'mux')
            if test -n "$NVIM"
              # Inside Neovim: Tell parent to open a NEW terminal split
              # <C-\><C-n> ensures we exit insert mode first
              # :vsplit | terminal -> opens terminal in vertical split
              ${mynvim}/bin/nvim --server "$NVIM" --remote-send "<C-\><C-n>:terminal<CR>i"
            else
              # Outside Neovim: Start nvim directly in terminal mode
              ${mynvim}/bin/nvim -c "terminal"
            end
          end
        '';

        # update nvim cwd
        cvd = let
          mynvim = self.packages.${pkgs.stdenv.hostPlatform.system}.neovix;
        in ''
          if test -n "$NVIM"
            ${mynvim}/bin/nvim --server "$NVIM" --remote-send "<C-\><C-n>:cd $(pwd)<CR>i"
          end
        '';
      };

      interactiveShellInit = ''
        set -g fish_greeting

        # carapace
        set -gx CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
        mkdir -p ~/.config/fish/completions
        carapace _carapace | source

        # completions show hidden files (Fish does this by default usually, but good to ensure)
        # setopt globdots is zsh specific, fish lists hidden files if you start with .

        # Keybindings
        bind \cv edit_command_buffer
      '';
    };
  };
}

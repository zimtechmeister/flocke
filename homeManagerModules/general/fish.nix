{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  options.my.fish.enable = lib.mkEnableOption "configure fish";
  config = lib.mkIf config.my.fish.enable {
    programs.carapace = {
      enable = true;
      enableFishIntegration = true;
    };
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
      };

      functions = {
        # yazi shell wrapper
        y = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          command yazi $argv --cwd-file="$tmp"
          if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';

        # avoid nested nvim instances
        mux = let
          mynvim = lib.getExe' self.packages.${pkgs.stdenv.hostPlatform.system}.neovix "nvim";
        in ''
          # Check if arguments (files) were provided
          if test -n "$argv[1]"
            # CASE 1: Files provided (e.g., 'mux test.lua')
            if test -n "$NVIM"
              # Inside Neovim: Tell parent to open the file(s)
              ${mynvim} --server "$NVIM" --remote $argv
            else
              # Outside Neovim: Open normally
              ${mynvim} $argv
            end
          else
            # CASE 2: No arguments provided (just typed 'mux')
            if test -n "$NVIM"
              # Inside Neovim: Tell parent to open a NEW terminal split
              # <C-\><C-n> ensures we exit insert mode first
              # :vsplit | terminal -> opens terminal in vertical split
              ${mynvim} --server "$NVIM" --remote-send "<C-\><C-n>:terminal<CR>i"
            else
              # Outside Neovim: Start nvim directly in terminal mode
              ${mynvim} -c "terminal"
            end
          end
        '';

        # update nvim cwd
        cvd = let
          mynvim = lib.getExe' self.packages.${pkgs.stdenv.hostPlatform.system}.neovix "nvim";
        in ''
          if test -n "$NVIM"
            ${mynvim} --server "$NVIM" --remote-send "<C-\><C-n>:cd $(pwd)<CR>i"
          end
        '';
      };

      interactiveShellInit = ''
        set -g fish_greeting
        fish_vi_key_bindings

        # carapace
        set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
        carapace _carapace | source

        # Keybindings
        bind \cv edit_command_buffer
      '';
    };
  };
}

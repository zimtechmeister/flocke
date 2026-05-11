{
  pkgs,
  inputs,
  ...
}: let
  packageName = "nvim";

  # Define plugins and extra packages
  plugins = with pkgs.vimPlugins; [
    # lsp
    nvim-lspconfig

    nvim-treesitter.withAllGrammars
    arrow-nvim # optional
    nvim-scrollbar # optional
    gitsigns-nvim
    markdown-preview-nvim
    # folke
    snacks-nvim
    which-key-nvim
    todo-comments-nvim
    flash-nvim
    # mini
    mini-ai
    mini-comment
    mini-pairs
    mini-surround
    mini-files
    mini-icons
    mini-cursorword
    mini-hipatterns
    mini-cmdline

    # colorschemes
    gruvbox-nvim
    # vim-moonfly-colors
    # vague-nvim
    # catppuccin-nvim
    # tokyonight-nvim
    # oxocarbon-nvim
    # everforest # sainnhe's version
    # (pkgs.vimUtils.buildVimPlugin {
    #   name = "everforest-nvim";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "neanias";
    #     repo = "everforest-nvim";
    #     rev = "main";
    #     hash = "sha256-q3rwQjC/462W6b8NLyBVZdWNVacfHlBBCoGQzaMAWoo=";
    #   };
    # })

    # gruvbox-material # sainnhe's version
    # gruvbox-material-nvim
  ];

  extraPackages = with pkgs; [
    # --- language servers(lsp), etc. ---
    copilot-language-server
    lua-language-server
    jdt-language-server # java
    clang-tools # c/c++
    nixd # nix
    nil # nix
    alejandra # nix formatter
    tinymist #typst
    vue-language-server
    # vscode-langservers-extracted # eslint
    vtsls # vue-ts-plugin
    tailwindcss-language-server

    # --- language specific tools ---
    #rust
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt

    gdb

    # --- Dependencies ---

    # Snacks image
    ghostscript
    mermaid-cli
    # Snacks picker
    sqlite
    inotify-tools

    # sidekick
    lsof
  ];

  # Replicate the project's robust plugin directory structure
  # This avoids manual runtimepath management in Lua
  packDir = pkgs.runCommand "nvim-pack-dir" {} ''
    mkdir -p $out/pack/${packageName}/start
    ${pkgs.lib.concatMapStringsSep "\n" (plugin: ''
        ln -s ${plugin} $out/pack/${packageName}/start/${pkgs.lib.getName plugin}
      '')
      plugins}
  '';
  # Create a self-contained environment using symlinkJoin
  # This is cleaner than buildEnv + manual 'rm bin/nvim'
in
  pkgs.symlinkJoin {
    name = "nvim-wrapped";
    paths = [inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default] ++ extraPackages;

    nativeBuildInputs = [pkgs.makeWrapper];

    postBuild = ''
      # Wrap the binary in-place in our new environment
      wrapProgram $out/bin/nvim \
        --add-flags '-u ${./lua/init.lua}' \
        --add-flags "--cmd 'set packpath^=${packDir} | set runtimepath^=${./lua},${packDir}'" \
        --prefix PATH : "$out/bin" \
        --set VUE_TS_PLUGIN_PATH "${pkgs.vue-language-server}/lib/language-tools/packages/language-server"

      # Robust aliasing
      ln -sf $out/bin/nvim $out/bin/vi
      ln -sf $out/bin/nvim $out/bin/vim
    '';
  }

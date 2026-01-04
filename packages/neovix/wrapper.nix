{
  pkgs,
  inputs,
}: let
  packageName = "mypackage";

  startPlugins = with pkgs.vimPlugins; [
    #lsp
    nvim-lspconfig

    #debugger
    nvim-dap
    nvim-dap-ui
    nvim-nio
    nvim-dap-virtual-text

    nvim-treesitter.withAllGrammars
    lualine-nvim
    arrow-nvim
    nvim-scrollbar
    gitsigns-nvim
    undotree
    markdown-preview-nvim
    # folke
    snacks-nvim
    which-key-nvim
    todo-comments-nvim
    noice-nvim
    flash-nvim
    sidekick-nvim
    # mini
    mini-ai
    mini-comment
    mini-pairs
    mini-surround
    mini-files
    mini-icons
    mini-cursorword
    mini-hipatterns

    # colorschemes
    vim-moonfly-colors
    vague-nvim
    gruvbox-nvim
    catppuccin-nvim
    tokyonight-nvim
    oxocarbon-nvim
    # everforest # sainnhe's version
    (pkgs.vimUtils.buildVimPlugin {
      name = "everforest-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "neanias";
        repo = "everforest-nvim";
        rev = "main";
        hash = "sha256-y0uLY2fx10fZvdHlsme9c8HZ3pz+kHOFS8OEgqeq4uU=";
      };
    })

    # gruvbox-material # sainnhe's version
    gruvbox-material-nvim
  ];

  foldPlugins = builtins.foldl' (
    acc: next:
      acc
      ++ [
        next
      ]
      ++ (foldPlugins (next.dependencies or []))
  ) [];

  startPluginsWithDeps = pkgs.lib.unique (foldPlugins startPlugins);

  extraPackages = with pkgs; [
    # --- language servers(lsp), etc. ---
    lua-language-server
    jdt-language-server
    clang-tools
    nixd
    alejandra # nix formatter
    copilot-language-server
    air-formatter
    tinymist
    texlab
    # typescript-language-server
    # vue-language-server
    vscode-langservers-extracted
    vtsls
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

  packpath = pkgs.runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${packageName}/{start,opt}

    ${
      pkgs.lib.concatMapStringsSep
      "\n"
      (plugin: "ln -vsfT ${plugin} $out/pack/${packageName}/start/${pkgs.lib.getName plugin}")
      startPluginsWithDeps
    }
  '';
in
  pkgs.symlinkJoin {
    name = "neovix";
    paths =
      [
        inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
        # pkgs.neovim-unwrapped # stable neovim
      ]
      ++ extraPackages;
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --add-flags '-u ${./nvim/init.lua}' \
        --add-flags "--cmd 'set packpath^=${packpath} | set runtimepath^=${./nvim},${packpath}'"
      ln -s $out/bin/nvim $out/bin/vi
      ln -s $out/bin/nvim $out/bin/vim
    '';

    passthru = {
      inherit packpath;
    };
  }

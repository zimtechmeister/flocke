{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    mypackages.enable =
      lib.mkEnableOption "enables packages for nixBTW";
  };
  config = lib.mkIf config.mypackages.enable {
    programs = {
      firefox.enable = true;

      nh = {
        enable = true;
        # flake = /home/tim/nixos;
        clean = {
          enable = true;
          extraArgs = "--keep 5 --keep-since 3d";
          dates = "daily";
        };
      };

      hyprland = {
        enable = true;
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
      };
    };
    hardware.opentabletdriver.enable = true;
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      neovide
      neovim

      #lsp server
      lua-language-server
      jdt-language-server
      eslint
      typescript-language-server
      nixd

      # nix formatter
      # nixfmt-rfc-style
      alejandra

      git
      # which zip thing do i want to use?
      gzip
      zip
      unzip

      ntfs3g
      ripgrep
      fd
      # languages
      gcc
      cmake
      meson
      nodejs
      yarn

      cpio
      killall
      wget
      pkg-config

      less
      fzf
      difftastic
      bat
      man
      man-db
      man-pages
      tldr
      trash-cli
      smartmontools
      lsd
      fastfetch
      yazi
      lazygit
      zoxide
      openconnect
      tmux
      yt-dlp
      # cronie

      # zsh
      # zsh-fzf-tab
      # zsh-autosuggestions
      # zsh-syntax-highlighting
      # zsh-vi-mode
      starship

      hyprland
      hypridle
      hyprlock
      hyprcursor
      hyprpaper
      hyprsunset
      hyprpicker
      grimblast
      wl-clipboard
      cliphist
      rofi-wayland
      rofimoji
      waybar
      swaynotificationcenter
      smartmontools
      pulsemixer
      pavucontrol
      easyeffects
      imv
      wev

      glib
      google-cursor

      kitty
      firefox
      chromium
      discord
      vesktop
      thunderbird
      gimp
      mpv
      pcmanfm
      zathura # do i need pdf mupdf?
      via
      prismlauncher
      gimp
      qimgv
      zoom-us
      localsend

      aquamarine
      hyprutils
      hyprlang

      jdk

      ghostty
      ulauncher
      anyrun
      walker # not working
    ];
    fonts.packages = with pkgs; [
      fira-code
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      monocraft # is this with nerd-fonts
      geist-font
      twemoji-color-font
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      google-fonts # how many fonts is this? maybe too many
    ];

    services.udev.packages = [pkgs.via];
  };
}

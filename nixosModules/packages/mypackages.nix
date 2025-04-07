{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    mypackages.enable =
      lib.mkEnableOption "enables packages for nixBTW";
  };
  config = lib.mkIf config.mypackages.enable {
    programs = {
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
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        shellInit = ''
          if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
              exec Hyprland
              # reccomended way to start hyprland
              # exec uwsm start hyprland.desktop
          fi
        '';
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
      harper

      # nix formater
      alejandra

      git
      # Which zip thing do I want to use?
      gzip
      zip
      unzip

      pandoc
      python312Packages.pylatexenc
      texliveMedium
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

      starship

      # hyprland
      # aquamarine
      # hyprutils
      # hyprlang
      hyprpolkitagent
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
      zathura
      via
      prismlauncher
      gimp
      qimgv
      zoom-us
      localsend

      jdk

      ghostty
      ulauncher
      anyrun
      walker # not working

      libsForQt5.kdenlive
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
      google-fonts # How many fonts is this? maybe too many
    ];

    services.udev.packages = [pkgs.via];
  };
}

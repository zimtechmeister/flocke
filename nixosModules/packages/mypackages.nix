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
        clean = {
          enable = true;
          extraArgs = "--keep 1 --keep-since 3d";
          dates = "hourly";
        };
      };

      localsend = {
        enable = true;
        openFirewall = true;
      };

      # NOTE: need to be enabled systemwide but are configured in home-manager
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
      };

      zsh = {
        enable = true;
      };
    };
    users.defaultUserShell = pkgs.zsh;

    hardware.opentabletdriver.enable = true;
    environment.systemPackages = with pkgs; [
      inputs.nix-alien.packages.${pkgs.system}.nix-alien
      neovide
      neovim

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
      imagemagick
      ntfs3g
      ripgrep
      fd
      # languages
      gcc
      cmake
      meson
      nodejs
      yarn
      python3

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
      # Screenshot
      grim
      slurp
      satty

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

      ghostty
      kitty
      firefox
      chromium
      discord
      vesktop
      thunderbird
      gimp
      mpv
      pcmanfm
      nautilus
      zathura
      via
      prismlauncher
      gimp
      qimgv
      zoom-us

      jdk
      R
      rstudio

      # experimental
      warp-terminal
      helix

      libsForQt5.kdenlive

      python312Packages.dbus-python
    ];
    services.udev.packages = [pkgs.via];
  };
}

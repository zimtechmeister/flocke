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

      # make home-manager
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

      # NOTE: needs to be enabled systemwide
      zsh = {
        enable = true;
      };
    };
    users.defaultUserShell = pkgs.zsh;

    hardware.opentabletdriver.enable = true;
    environment.systemPackages = with pkgs; [
      # languages
      jdk
      gcc
      cmake
      meson
      nodejs
      yarn
      python3
      pipenv
      rustc
      cargo

      # cli tools
      neovim
      git
      lazygit
      gzip
      zip
      unzip
      cpio
      killall
      wget
      pkg-config # what is this
      ntfs3g
      ripgrep
      fd
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
      zoxide
      openconnect
      wireguard-tools
      yt-dlp
      inputs.nix-alien.packages.${pkgs.system}.nix-alien

      # NOTE: probaply dont need this anymore(there are flakes for eduroam)
      # python312Packages.dbus-python

      # do i really need this
      typst
      pandoc
      texliveFull
      imagemagick
      python312Packages.pylatexenc

      starship # configure in home-manager

      # desktop environment
      hyprsunset # configure in home-manager
      hyprpicker

      grim
      slurp
      satty

      wl-clipboard
      cliphist
      wev
      waybar
      swaynotificationcenter
      smartmontools
      pulsemixer

      # some progams
      pavucontrol
      easyeffects

      glib # what do i need this fore? i thik this is some dependency

      ghostty

      firefox
      chromium

      discord
      thunderbird

      pcmanfm
      nautilus
      zathura
      mpv
      imv
      qimgv # might take a long time to complie? does it depend on deno?

      zoom-us

      # only desktop?
      via
      libsForQt5.kdenlive
      gimp
    ];
    services.udev.packages = [pkgs.via];
  };
}

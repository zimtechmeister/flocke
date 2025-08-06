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

      # TODO: make home-manager
      localsend = {
        enable = true;
        openFirewall = true;
      };

      # uwsm = {
      #   enable = true;
      #   waylandCompositors = {
      #     hyprland = {
      #       prettyName = "Hyprland";
      #       comment = "Hyprland compositor managed by UWSM";
      #       # NOTE :It is recommended to use the /run/current-system/sw/bin/ path
      #       # instead of lib.getExe pkgs.<compositor> to avoid version mismatch of
      #       # the compositor used by UWSM and the one installed in the system.
      #       binPath = "/run/current-system/sw/bin/Hyprland";
      #     };
      #     niri = {
      #       prettyName = "Niri";
      #       comment = "Niri compositor managed by UWSM";
      #       binPath = pkgs.writeShellScript "niri" ''
      #         ${lib.getExe config.programs.niri.package} --session
      #       '';
      #     };
      #   };
      # };

      # NOTE: need to be enabled systemwide but are configured in home-manager
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
        # withUWSM = true;
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
      gnumake
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
      lazygit
      gzip
      zip
      unzip
      cpio
      killall
      wget
      ntfs3g
      ripgrep
      fd
      less
      difftastic
      bat
      man
      man-db
      man-pages
      tldr
      pkg-config # what is this
      trash-cli
      smartmontools
      lsd
      yazi
      openconnect
      wireguard-tools
      yt-dlp
      gemini-cli
      claude-code
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

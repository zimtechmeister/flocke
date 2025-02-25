{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings = {
    warn-dirty = false;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  networking.hostName = "nixBTW";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  users.users.tim = {
    isNormalUser = true;
    description = "tim";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    useDefaultShell = true;
    # shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "tim" = import ./home.nix;
    };
    backupFileExtension = "hm-backup";
  };

  programs = {
    firefox.enable = true;

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

  # Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  # this is for the nixd lsp to get the pkgs from the flake if im correct?
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  services.udev.packages = [pkgs.via];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

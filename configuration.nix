{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    # ./main-user.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # main-user = {
  #   enable = true;
  #   userName = "tim";
  # };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  networking.hostName = "nixBTW";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  users.users.tim = {
    isNormalUser = true;
    description = "tim";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      thunderbird
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "tim" = import ./home.nix;
    };
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
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

  # Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovide
    neovim
    lua-language-server
    jdt-language-server
    eslint
    typescript-language-server
    nixd
    nixfmt-rfc-style

    git
    zip
    unzip
    ntfs3g
    ripgrep
    fd
    gcc
    cmake
    meson
    cpio
    pkg-config
    nodejs
    wget
    killall
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

    #grimshot
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

    aquamarine
    hyprutils
    hyprlang

    jdk

    ghostty
    ulauncher
    anyrun
  ];
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
    twemoji-color-font
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
  ];

  services.udev.packages = [ pkgs.via ];

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

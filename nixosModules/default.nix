{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./desktop
    ./general
    ./server

    ./cachix.nix
    ./stylix.nix
  ];

  my = {
    desktop.enable = lib.mkDefault false;
    general.enable = lib.mkDefault true;
    server.enable = lib.mkDefault false;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # this is for the nixd lsp to get the pkgs from the flake if im correct?
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  boot.loader.limine = {
    enable = true;
    package = pkgs.limine-full;
    extraEntries = ''
      /Windows 11
      protocol: efi
      path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';
    secureBoot = {
      enable = true;
      sbctl = pkgs.sbctl;
      autoGenerateKeys = true;
      autoEnrollKeys = {
        enable = true;
        extraArgs = [
          "--microsoft"
          "--firmware-builtin"
          "--ignore-immutable"
        ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
  sbctl
  ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

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

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    # Electron apps to use Wayland:
    NIXOS_OZONE_WL = "1";
  };

  users.users.tim = {
    isNormalUser = true;
    description = "tim";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    useDefaultShell = true;
  };

  system.stateVersion = "26.05";
}

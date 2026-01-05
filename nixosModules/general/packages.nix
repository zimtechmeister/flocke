{
  pkgs,
  inputs,
  lib,
  config,
  self,
  ...
}: {
  options.my.general-packages.enable = lib.mkEnableOption "general-packages";
  config = lib.mkIf config.my.general-packages.enable {
    environment.systemPackages = with pkgs; [
      # languages
      jdk

      gcc
      gnumake
      cmake
      meson

      nodejs
      yarn
      pnpm
      bun
      R

      python3
      pipenv

      rustc
      cargo

      # cli tools
      bottom
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
      openconnect
      wireguard-tools
      yt-dlp
      gemini-cli
      inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien
      self.packages.${pkgs.stdenv.hostPlatform.system}.neovix
    ];
  };
}

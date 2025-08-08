{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    general-packages.enable =
      lib.mkEnableOption "general-packages";
  };
  config = lib.mkIf config.general-packages.enable {
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
      openconnect
      wireguard-tools
      yt-dlp
      gemini-cli
      claude-code
      inputs.nix-alien.packages.${pkgs.system}.nix-alien

      typst
      pandoc
      texliveFull
      imagemagick
      python312Packages.pylatexenc
    ];
  };
}

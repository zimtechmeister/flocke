{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./swaync
  ];

  home.username = "tim";
  home.homeDirectory = "/home/tim";

  xdg.mimeApps.defaultApplications = {
    "text/plain" = ["neovide.desktop"];
    "image/*" = ["imv.desktop"]; # qimgv.desktop
    "video/*" = ["mpv.desktop"];
    "inode/directory" = ["pcmanfm.desktop"];
    "application/pdf" = ["zen-beta.desktop"]; # zathura.desktop
    "text/html" = ["zen-beta.desktop"];
    "x-scheme-handler/about" = ["zen-beta.desktop"];
    "x-scheme-handler/http" = ["zen-beta.desktop"];
    "x-scheme-handler/https" = ["zen-beta.desktop"];
    "x-scheme-handler/unknown" = ["zen-beta.desktop"];
    "x-scheme-handler/webcal" = ["zen-beta.desktop"];
  };

  programs = {
    git = {
    enable = true;
    userName = "Tim Zechmeister";
    userEmail = "tim.zechmeister03@gmail.com";
    };

    # this is problematic
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   autosuggestion.enable = true;
    #   syntaxHighlighting.enable = true;
    # };
  };

  xdg.configFile."starship.toml".source = ./starship.toml;

  home.packages = [
    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  home.file = {
    # you could source your .zshrc here for example
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

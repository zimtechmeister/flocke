{pkgs, ...}: let
  gruvbox-dark = {
    base00 = "282828"; #282828
    base01 = "3c3836"; #3c3836
    base02 = "504945"; #504945
    base03 = "665c54"; #665c54
    base04 = "928374"; #928374
    base05 = "ebdbb2"; #ebdbb2
    base06 = "fbf1c7"; #fbf1c7
    base07 = "f9f5d7"; #f9f5d7
    base08 = "cc241d"; #cc241d
    base09 = "d65d0e"; #d65d0e
    base0A = "d79921"; #d79921
    base0B = "98971a"; #98971a
    base0C = "689d6a"; #689d6a
    base0D = "458588"; #458588
    base0E = "b16286"; #b16286
    base0F = "9d0006"; #9d0006
    base10 = "2a2520"; #2a2520
    base11 = "1d1d1d"; #1d1d1d
    base12 = "fb4934"; #fb4934
    base13 = "fabd2f"; #fabd2f
    base14 = "b8bb26"; #b8bb26
    base15 = "8ec07c"; #8ec07c
    base16 = "83a598"; #83a598
    base17 = "d3869b"; #d3869b
  };
in {
  stylix = {
    enable = true;

    # NOTE: collection of colorschemes https://tinted-theming.github.io/tinted-gallery/
    base16Scheme = gruvbox-dark;
    # somehow this wont work
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    polarity = "dark";

    # NOTE: premade script wont work as nice
    # image = config.lib.stylix.pixel "base17";

    # NOTE: reference implementation modified it a bit https://nix-community.github.io/stylix/tricks.html#dynamic-wallpaper-generation-based-on-selected-theme
    # image = pkgs.runCommand "image.png" {} ''
    #   ${lib.getExe pkgs.imagemagick} -size 1920x1080 xc:"#${config.stylix.base16Scheme.base11}" $out
    # '';

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zimtechmeister/wallpaper/refs/heads/master/forest-shroom.jpg";
      hash = "sha256-q4rsjdaAnjeMFHh56cHr0t58VHj0wfouCYdT90HtAO0=";
    };

    # NOTE: this somehow has no effect
    # thats why i have to use my own script to generate the image and match my monitors size
    imageScalingMode = "tile"; # one of "stretch", "fill", "fit", "center", "tile"

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 24;
    };

    fonts = {
      sizes = {
        terminal = 12;
        applications = 12;
        desktop = 12;
        popups = 12;
      };
      monospace = {
        name = "Maple Mono NF";
        package = pkgs.maple-mono.NF;
      };
      sansSerif = {
        name = "Geist";
        package = pkgs.geist-font;
      };
      serif = {
        name = "Geist";
        package = pkgs.geist-font;
      };
      emoji = {
        name = "Twitter Color Emoji";
        package = pkgs.twemoji-color-font;
      };
    };
  };
}

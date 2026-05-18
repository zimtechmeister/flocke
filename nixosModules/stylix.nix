{
  pkgs,
  lib,
  self,
  ...
}: let
  theme = self.themeNoHash;
in {
  stylix = {
    enable = true;

    # NOTE: collection of colorschemes https://tinted-theming.github.io/tinted-gallery/
    base16Scheme = theme.colors;
    polarity = "dark";

    # ... rest of the config ...

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zimtechmeister/wallpaper/refs/heads/master/maelifell-iceland.jpeg";
      hash = "sha256-e6EF1+NsNQ/jtokInzVRPxx9XSjN7zSWQCfeGD0qjg8=";
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
        name = theme.fonts.monospace.name;
        package = lib.attrByPath theme.fonts.monospace.package null pkgs;
      };
      sansSerif = {
        name = theme.fonts.sansSerif.name;
        package = lib.attrByPath theme.fonts.sansSerif.package null pkgs;
      };
      serif = {
        name = theme.fonts.serif.name;
        package = lib.attrByPath theme.fonts.serif.package null pkgs;
      };
      emoji = {
        name = theme.fonts.emoji.name;
        package = lib.attrByPath theme.fonts.emoji.package null pkgs;
      };
    };
  };
}

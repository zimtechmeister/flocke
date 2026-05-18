{...}: let
  colors = {
    base00 = "#282828";
    base01 = "#3c3836";
    base02 = "#504945";
    base03 = "#665c54";
    base04 = "#928374";
    base05 = "#ebdbb2";
    base06 = "#fbf1c7";
    base07 = "#f9f5d7";
    base08 = "#cc241d";
    base09 = "#d65d0e";
    base0A = "#d79921";
    base0B = "#98971a";
    base0C = "#689d6a";
    base0D = "#458588";
    base0E = "#b16286";
    base0F = "#9d0006";
    base10 = "#2a2520";
    base11 = "#1d1d1d";
    base12 = "#fb4934";
    base13 = "#fabd2f";
    base14 = "#b8bb26";
    base15 = "#8ec07c";
    base16 = "#83a598";
    base17 = "#d3869b";
  };

  fonts = {
    monospace = {
      name = "Maple Mono NF";
      package = ["maple-mono" "NF"];
    };
    sansSerif = {
      name = "Geist";
      package = ["geist-font"];
    };
    serif = {
      name = "Geist";
      package = ["geist-font"];
    };
    emoji = {
      name = "Noto Color Emoji";
      package = ["noto-fonts-color-emoji"];
    };
  };

  stripHash = str:
    if builtins.substring 0 1 str == "#"
    then builtins.substring 1 (builtins.stringLength str - 1) str
    else str;

  colorsNoHash = builtins.mapAttrs (_: v: stripHash v) colors;
in {
  flake = {
    theme = {
      inherit colors fonts;
    };
    themeNoHash = {
      colors = colorsNoHash;
      inherit fonts;
    };
  };
}

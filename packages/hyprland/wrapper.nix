{
  lib,
  pkgs,
  inputs,
  theme ? null,
  ...
}: let
  # Generate theme.lua
  themeLua = let
    theme' =
      if theme != null
      then theme
      else {};
    colors = let
      allColors = theme'.colors or {};
      filtered = pkgs.lib.filterAttrs (n: v: (pkgs.lib.hasPrefix "base" n) && !(pkgs.lib.hasInfix "-" n)) allColors;
    in
      pkgs.lib.mapAttrs (n: v: "#${v}") filtered;
    fonts = theme'.fonts or {};
    toLuaTableEntries = attrs: let
      stringAttrs = pkgs.lib.filterAttrs (n: v: builtins.isString v) attrs;
    in
      pkgs.lib.concatStringsSep "\n    " (pkgs.lib.mapAttrsToList (name: value: "${name} = \"${value}\",") stringAttrs);
  in
    pkgs.writeText "theme.lua" ''
      return {
        colors = {
          ${toLuaTableEntries colors}
        },
        fonts = {
          ${toLuaTableEntries fonts}
        }
      }
    '';

  nixLua = pkgs.writeText "nix.lua" ''
    return {
      noctalia-shell = "${lib.getExe inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}"
      ghostty = "${lib.getExe pkgs.ghostty}"
    }
  '';
  # Create a directory for the config files
  configDir = pkgs.symlinkJoin {
    name = "hyprland-config";
    paths = [
      ./lua
      (pkgs.linkFarm "hyprland-theme" [
        {
          name = "theme.lua";
          path = themeLua;
        }
        {
          name = "nix.lua";
          path = nixLua;
        }
      ])
    ];
  };

  extraPackages = with pkgs; [
    ghostty
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
in
  pkgs.symlinkJoin {
    name = "hyprland-wrapped";
    inherit (inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland) version;
    paths =
      [
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
      ]
      ++ extraPackages;

    nativeBuildInputs = [pkgs.makeWrapper];

    postBuild = ''
      wrapProgram $out/bin/hyprland \
        --add-flags "-c ${configDir}/hyprland.lua" \
        --set HYPRLAND_CONFIG "${configDir}/hyprland.lua" \
        --prefix PATH : "$out/bin"

      if [ -f $out/bin/start-hyprland ]; then
        wrapProgram $out/bin/start-hyprland \
          --set HYPRLAND_CONFIG "${configDir}/hyprland.lua" \
          --prefix PATH : "$out/bin"
      fi
    '';
  }

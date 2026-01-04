{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options.my.hyprland.enable = lib.mkEnableOption "hyprland";
  config = lib.mkIf config.my.hyprland.enable {
    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        # withUWSM = true;
      };

      # uwsm = {
      #   enable = true;
      #   waylandCompositors = {
      #     hyprland = {
      #       prettyName = "Hyprland";
      #       comment = "Hyprland compositor managed by UWSM";
      #       # NOTE :It is recommended to use the /run/current-system/sw/bin/ path
      #       # instead of lib.getExe pkgs.<compositor> to avoid version mismatch of
      #       # the compositor used by UWSM and the one installed in the system.
      #       binPath = "/run/current-system/sw/bin/Hyprland";
      #     };
      #     niri = {
      #       prettyName = "Niri";
      #       comment = "Niri compositor managed by UWSM";
      #       binPath = pkgs.writeShellScript "niri" ''
      #         ${lib.getExe config.programs.niri.package} --session
      #       '';
      #     };
      #   };
      # };
    };
  };
}

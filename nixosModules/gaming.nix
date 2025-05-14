{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gaming.enable =
      lib.mkEnableOption "enables gaming support";
  };
  config = lib.mkIf config.gaming.enable {
    # NOTE: in steam set for specified game launch options
    # gamescope %command%
    # gamemoderun %command%
    # mangohud %command%
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      mangohud
      prismlauncher
    ];
  };
}

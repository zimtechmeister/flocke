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

    # NOTE: for protonGE run command & select in steam games compatibility menu
    # protonup -d "~/.steam/root/compatibilitytools.d/"
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      mangohud
      protonup
      prismlauncher
    ];
  };
}

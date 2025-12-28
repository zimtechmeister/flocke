{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.gaming.enable = lib.mkEnableOption "enables gaming support";
  config = lib.mkIf config.my.gaming.enable {
    # NOTE: there is a nixgaming flake https://github.com/fufexan/nix-gaming
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

{
  lib,
  config,
  ...
}: {
  imports = [
    ./dyndns.nix
    ./frp.nix
    ./immich.nix
    ./minecraft-server.nix
    ./nextcloud.nix
    ./nginx.nix
  ];

  options.server.enable = lib.mkEnableOption "enables server nixos-module";

  config = lib.mkIf config.server.enable {
    dyndns.enable = lib.mkDefault false;
    frp.enable = lib.mkDefault true;
    immich.enable = lib.mkDefault true;
    minecraft-server.enable = lib.mkDefault false; # waiting for minecraftctl to be merged
    nextcloud.enable = lib.mkDefault true;
    nginx.enable = lib.mkDefault true;
  };
}

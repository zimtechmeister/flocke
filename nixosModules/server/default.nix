{
  lib,
  config,
  ...
}: {
  imports = [
    ./dyndns.nix
    ./immich.nix
    ./minecraft-server.nix
    ./newt.nix
    ./nextcloud.nix
  ];

  options.server.enable = lib.mkEnableOption "enables server nixos-module";

  config = lib.mkIf config.server.enable {
    dyndns.enable = lib.mkDefault false;
    immich.enable = lib.mkDefault true;
    minecraft-server.enable = lib.mkDefault false; # waiting for minecraftctl to be merged
    newt.enable = lib.mkDefault true;
    nextcloud.enable = lib.mkDefault true;
  };
}

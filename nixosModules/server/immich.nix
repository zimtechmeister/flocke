{
  lib,
  config,
  ...
}: {
  options = {
    immich.enable = lib.mkEnableOption "immich";
  };
  config = lib.mkIf config.immich.enable {
    services.immich = {
      enable = true;
      port = 2283;
      host = "0.0.0.0";
      openFirewall = true;
      accelerationDevices = null; # null gives access to all devices
    };
    users.users.immich.extraGroups = ["video" "render"];
  };
}

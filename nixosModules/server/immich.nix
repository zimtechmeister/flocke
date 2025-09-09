{
  pkgs,
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
      host = "127.0.0.1";
      openFirewall = false; # not needed, it's behind nginx
      settings.server.externalDomain = "https://immich.timzechmeister.de";
      accelerationDevices = null; # null gives access to all devices
    };

    # Accelerated Video Playback
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable
    users.users.immich.extraGroups = ["video" "render"];
  };
}

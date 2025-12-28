{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.immich.enable = lib.mkEnableOption "immich";
  config = lib.mkIf config.my.immich.enable {
    services.immich = {
      enable = true;
      port = 2283;
      # host = "immich.timzechmeister.de";
      openFirewall = false;
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

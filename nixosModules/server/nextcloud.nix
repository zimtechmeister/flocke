{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nextcloud.enable = lib.mkEnableOption "nextcloud";
  };
  config = lib.mkIf config.nextcloud.enable {
    services = {
      nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;
        # hostName = "nextcloud.timzechmeister.dynv6.net";
        hostName = "timzechmeister.dynv6.net";
        https = true;
        configureRedis = true;
        maxUploadSize = "1G";
        settings.default_phone_region = "DE";
        config = {
          dbtype = "sqlite";
          # TODO: hide password
          adminuser = "ding";
          adminpassFile = "ding";
        };
        settings = {
          trusted_domains = [
            "192.168.0.20"
            "timzechmeister.dynv6.net"
            # "nextcloud.timzechmeister.dynv6.net"
            "timzechmeister.de"
          ];
          # Disable external storage by default for security
          # "allow_local_remote_servers" = false;
        };
      };
    };
  };
}

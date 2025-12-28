{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.nextcloud.enable = lib.mkEnableOption "nextcloud";
  config = lib.mkIf config.my.nextcloud.enable {
    # TODO: hide password
    environment.etc."nextcloud-admin-pass".text = "";
    services = {
      nextcloud = {
        enable = true;
        # need to manually increment with new nextcloud versions
        package = pkgs.nextcloud32;
        hostName = "localhost";
        https = false;
        configureRedis = true;
        maxUploadSize = "1G";
        # Storage path of nextcloud
        # home = "/var/lib/nextcloud";
        config = {
          dbtype = "sqlite";
          adminuser = "root";
          adminpassFile = "/etc/nextcloud-admin-pass";
        };
        settings = {
          default_phone_region = "DE";
          trusted_domains = [
            "nextcloud.timzechmeister.de"
            "192.168.0.3"
            "localhost"
          ];
          # Disable external storage by default for security
          # "allow_local_remote_servers" = false;
        };
      };
    };
  };
}

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
    # TODO: hide password
    environment.etc."nextcloud-admin-pass".text = "";
    services = {
      nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;
        hostName = "timzechmeister.de";
        https = true;
        configureRedis = true;
        maxUploadSize = "1G";
        settings.default_phone_region = "DE";
        config = {
          dbtype = "sqlite";
          adminuser = "root";
          adminpassFile = "/etc/nextcloud-admin-pass";
        };
        settings = {
          trusted_domains = [
            "timzechmeister.de"
          ];
          # Disable external storage by default for security
          # "allow_local_remote_servers" = false;
        };
      };
    };
  };
}

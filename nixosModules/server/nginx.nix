{
  lib,
  config,
  ...
}: {
  options = {
    nginx.enable = lib.mkEnableOption "nginx";
  };
  config = lib.mkIf config.nginx.enable {
    security.acme = {
      acceptTerms = true;
      defaults.email = "tim.zechmeister03@gmail.com";
    };
    services.nginx = {
      enable = true;
      virtualHosts = {
        # Nextcloud
        "timzechmeister.de" = { # TODO: rename to cloud.timzechmeister.de or use config.services.nextcloud.hostName
          addSSL = true;
          enableACME = true;
          # Nextcloud config is injected automatically here
        };
        # Immich
        "immich.timzechmeister.de" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:2283";
            proxyWebsockets = true;
          };
        };
      };
    };
    # TODO: not nice
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options = {
    frp.enable = lib.mkEnableOption "frp";
  };
  config = lib.mkIf config.frp.enable {
    services.frp = {
      enable = true;
      role = "client";
      settings = {
        serverAddr = "159.69.152.37";
        serverPort = 7000;
        auth = {
          method = "token";
          # TODO: hide password
          token = "";
        };
        proxies = [
          {
            name = "nextcloud";
            type = "https";
            localIP = "127.0.0.1";
            localPort = 443;
            customDomains = ["timzechmeister.de"]; # TODO: rename to cloud.timzechmeister.de or use config.services.nextcloud.hostName
          }
          {
            name = "immich";
            type = "https";
            localIP = "127.0.0.1";
            localPort = 443;
            customDomains = ["immich.timzechmeister.de"];
          }
        ];
      };
    };
  };
}

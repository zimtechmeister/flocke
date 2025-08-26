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
        "timzechmeister.de" = {
          addSSL = true;
          enableACME = true;
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

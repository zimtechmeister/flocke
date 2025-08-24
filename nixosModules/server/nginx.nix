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
      # NOTE: where do i eneable this if i need it for multiple modules
      enable = true; # this is automatically set to true by the nextcloud thing
      virtualHosts = {
        "timzechmeister.dynv6.net" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://localhost:8080";
            proxyWebsockets = true;
          };
        };
        # "nextcloud.timzechmeister.dynv6.net" = {
        #   addSSL = true;
        #   enableACME = true;
        #   locations."/" = {
        #     proxyPass = "http://localhost:8080";
        #     proxyWebsockets = true;
        #   };
        # };
        # "immich.local" = {
        #   # forceSSL = true;
        #   # enableACME = true;
        #   # locations."/immich" = {
        #   #   proxyPass = "http://localhost:2283";
        #   # };
        # };
      };
    };
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
    };
  };
}

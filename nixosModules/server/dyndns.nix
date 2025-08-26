{
  lib,
  config,
  ...
}: {
  options = {
    dyndns.enable = lib.mkEnableOption "dyndns";
  };
  config = lib.mkIf config.dyndns.enable {
    # TODO: hide password
    environment.etc."cloudflare-dyndns-api-token".text = "";
    # services.cfdyndns # also exists
    services.cloudflare-dyndns = {
      enable = true;
      domains = ["timzechmeister.de"];
      apiTokenFile = "/etc/cloudflare-dyndns-api-token";
      ipv4 = false;
      ipv6 = true;
      proxied = false;
    };
  };
}

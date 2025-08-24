{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    dyndns.enable = lib.mkEnableOption "dyndns";
  };
  config = lib.mkIf config.dyndns.enable {
    # NOTE: this is only temporary cause with the fritzbox router i wont need another dynamic dns service
    services.ddclient = {
      enable = true;
      # TODO: hide password
      configFile = pkgs.writeText "my-config-file" ''
        protocol=dyndns2
        server=dynv6.com
        login=none
        password='password'
        use=web, web=ipv6.icanhazip.com
        timzechmeister.dynv6.net
      '';
    };
  };
}

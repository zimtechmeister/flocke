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
    services.ddclient = {
      enable = true;
      # TODO: hide password
      configFile = pkgs.writeText "my-config-file" ''
        protocol=dyndns2
        server=dynv6.com
        login=none
        password='password123'
        use=cmd, cmd="${pkgs.iproute2}/bin/ip -6 addr show dev wlp3s0 scope global | ${pkgs.gawk}/bin/awk '/inet6/{print $2}' | cut -d/ -f1 | head -n1"
        timzechmeister.dynv6.net
        immich-tim.dynv6.net
      '';
    };
  };
}

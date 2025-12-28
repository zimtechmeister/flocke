{
  lib,
  config,
  ...
}: {
  options.my.newt.enable = lib.mkEnableOption "pangolin";
  config = lib.mkIf config.my.newt.enable {
    environment.etc."newt-secret".text = ''
    '';
    services.newt = {
      enable = true;
      # settings = {
      #   endpoint = "https://pangolin.timzechmeister.de";
      # };
      environmentFile = "/etc/newt-secret";
    };
  };
}

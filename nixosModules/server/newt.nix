{
  lib,
  config,
  ...
}: {
  options = {
    newt.enable = lib.mkEnableOption "pangolin";
  };
  config = lib.mkIf config.newt.enable {
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

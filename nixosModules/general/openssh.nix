{
  lib,
  config,
  ...
}: {
  options = {
    openssh.enable =
      lib.mkEnableOption "openssh";
  };
  config = lib.mkIf config.openssh.enable {
    services.openssh = {
      enable = true;
    };
  };
}

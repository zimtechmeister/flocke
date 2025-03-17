{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    bluetooth.enable =
      lib.mkEnableOption "enables bluetooth support";
  };
  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}

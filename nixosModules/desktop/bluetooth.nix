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
      powerOnBoot = false;
    };
    services.blueman.enable = true;
    environment.systemPackages = with pkgs; [
      zmkBATx
    ];
  };
}

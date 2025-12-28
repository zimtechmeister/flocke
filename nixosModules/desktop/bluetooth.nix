{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.bluetooth.enable = lib.mkEnableOption "enables bluetooth support";
  config = lib.mkIf config.my.bluetooth.enable {
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

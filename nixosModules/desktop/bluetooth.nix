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
    environment.systemPackages = with pkgs; [
      zmkBATx
    ];
  };
}

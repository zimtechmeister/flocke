{
  lib,
  config,
  ...
}: {
  options.my.laptop.enable = lib.mkEnableOption "enables laptop support";
  config = lib.mkIf config.my.laptop.enable {
    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
      logind.settings.Login = {
        HandleLidSwitch = "ignore";
        KillUserProcesses = false;
      };
    };
  };
}

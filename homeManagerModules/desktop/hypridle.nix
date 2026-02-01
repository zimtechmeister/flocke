{
  lib,
  config,
  pkgs,
  ...
}: {
  options.my.hypridle.enable = lib.mkEnableOption "enables hypridle";
  config = lib.mkIf config.my.hypridle.enable {
    home.packages = with pkgs; [
      brightnessctl
    ];
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

        listener = [
          {
            timeout = 600; # 10min.
            on-timeout = "brightnessctl -s set 5%"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
            on-resume = "brightnessctl -r"; # monitor backlight restore.
          }
          {
            timeout = 840; # 14min
            on-timeout = "noctalia-shell ipc call toast send '{\"title\": \"Sleep\", \"body\": \"System will go to sleep shortly\", \"icon\": \"moon\"}'";
          }
          {
            timeout = 900; # 15min
            on-timeout = "noctalia-shell ipc call sessionMenu lockAndSuspend && hyprctl dispatch dpms off"; # lock and suspend && screen off when timeout has passed
          }
        ];
      };
    };
  };
}

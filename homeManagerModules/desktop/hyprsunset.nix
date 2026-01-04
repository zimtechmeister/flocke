{
  lib,
  config,
  ...
}: {
  options.my.hyprsunset.enable = lib.mkEnableOption "hyprsunset";
  config = lib.mkIf config.my.hyprsunset.enable {
    services.hyprsunset = {
      # TODO: this could be usefull for using this without systemd
      # systemd.services.sshd.wantedBy = lib.mkForce [ ];
      enable = true;
      systemdTarget =
        if !config.my.hyprland.enable && config.my.niri.enable
        then "niri.service"
        else config.wayland.systemd.target;
      settings = {
        max-gamma = 150;

        profile = [
          {
            time = "6:30";
            identity = true;
          }
          {
            time = "22:00";
            temperature = 5000;
            gamma = 0.8;
          }
        ];
      };
    };
  };
}

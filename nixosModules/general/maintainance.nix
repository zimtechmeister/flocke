{
  lib,
  config,
  ...
}: {
  options.my.maintainance.enable = lib.mkEnableOption "maintainance";
  config = lib.mkIf config.my.maintainance.enable {
    programs = {
      nh = {
        enable = true;
        # clean = {
        #   enable = true;
        #   extraArgs = "--keep 3 --keep-since 3d";
        #   dates = "hourly";
        # };
      };
    };
    nix.gc = {
      automatic = true;
      dates = "01:00";
      randomizedDelaySec = "45min";
      persistent = true;
      options = "--delete-older-than 3d";
    };
    nix.optimise = {
      automatic = true;
      dates = ["03:45"];
      randomizedDelaySec = "45min";
      persistent = true;
    };
  };
}

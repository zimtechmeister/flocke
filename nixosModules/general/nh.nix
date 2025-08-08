{
  lib,
  config,
  ...
}: {
  options = {
    nh.enable =
      lib.mkEnableOption "nh";
  };
  config = lib.mkIf config.nh.enable {
    programs = {
      nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep 3 --keep-since 3d";
          dates = "hourly";
        };
      };
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options.mongo.enable =
    lib.mkEnableOption "enables home-manager for nixBTW";

  config = lib.mkIf config.mongo.enable {
    home = {
      username = "tim";
      homeDirectory = "/home/tim";

      stateVersion = "24.11"; # Please read the comment before changing.
    };
    # Let's Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}

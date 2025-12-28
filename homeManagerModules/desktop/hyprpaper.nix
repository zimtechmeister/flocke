{
  lib,
  config,
  ...
}: {
  options.my.hyprpaper.enable = lib.mkEnableOption "enables hyprpaper";
  config = lib.mkIf config.my.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      # settings = {
      #   # supported formats: png, jpg, jpeg, webp
      #   preload = "${config.stylix.image}";
      #
      #   wallpaper = [
      #     "eDP-1,${config.stylix.image}"
      #     "DP-1,${config.stylix.image}"
      #     "HDMI-A-2,${config.stylix.image}"
      #   ];
      #
      #   ipc = false;
      # };
    };
  };
}

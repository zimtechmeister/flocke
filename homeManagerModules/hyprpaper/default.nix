{
  lib,
  config,
  ...
}: {
  options.hyprpaper.enable = lib.mkEnableOption "enables hyprpaper";
  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        # supported formats: png, jpg, jpeg, webp
        preload = "~/.config/wallpaper/forest-shroom.jpg";

        wallpaper = [
          "eDP-1,~/.config/wallpaper/forest-shroom.jpg"
          "DP-1,~/.config/wallpaper/forest-shroom.jpg"
          "HDMI-A-2,~/.config/wallpaper/forest-shroom.jpg"
        ];

        ipc = false;
      };
    };
  };
}

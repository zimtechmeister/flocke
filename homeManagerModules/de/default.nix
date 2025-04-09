{
  lib,
  config,
  ...
}: {
  imports = [
    ./swaync
    ./hyprland
    ./waybar
  ];

  options = {
    de.enable =
      lib.mkEnableOption "enables the desktop environment";
  };

  config = lib.mkIf config.de.enable {
    hyprland.enable =
      lib.mkDefault true;
    swaync.enable =
      lib.mkDefault true;
    waybar.enable =
      lib.mkDefault true;
  };
}

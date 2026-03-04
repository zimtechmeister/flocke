{
  lib,
  config,
  ...
}: {
  options.my.hyprland.enable = lib.mkEnableOption "hyprland";
  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = false;
    };
  };
}

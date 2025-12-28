{
  lib,
  config,
  ...
}: {
  options.my.hyprpolkitagent.enable = lib.mkEnableOption "enables hyprpolkitagent";
  config = lib.mkIf config.my.hyprpolkitagent.enable {
    services.hyprpolkitagent.enable = true;
  };
}

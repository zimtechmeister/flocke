{
  lib,
  config,
  ...
}: {
  options.hyprpolkitagent.enable = lib.mkEnableOption "enables hyprpolkitagent";
  config = lib.mkIf config.hyprpolkitagent.enable {
    services.hyprpolkitagent.enable = true;
  };
}

{
  lib,
  config,
  ...
}: {
  options.my.evolution-data-server.enable = lib.mkEnableOption "evolution-data-server for calendar support";
  config = lib.mkIf config.my.evolution-data-server.enable {
    services.gnome.evolution-data-server.enable = true;
  };
}

{
  lib,
  config,
  ...
}: {
  options.dbs.enable = lib.mkEnableOption "enables postgresql";
  config = lib.mkIf config.dbs.enable {
    services.postgresql = {
      enable = true;
      ensureDatabases = [
        "Einzelhandel"
        "Hundeschule"
        "Escaperoom"
      ];
    };
  };
}

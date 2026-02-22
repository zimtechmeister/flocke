{
  lib,
  config,
  ...
}: {
  options.my.nushell.enable = lib.mkEnableOption "configure nushell";
  config = lib.mkIf config.my.nushell.enable {
    programs.nushell = {
      enable = true;
    };
  };
}

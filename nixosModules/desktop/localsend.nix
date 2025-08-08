{
  lib,
  config,
  ...
}: {
  options.localsend.enable = lib.mkEnableOption "localsend";
  config = lib.mkIf config.localsend.enable {
    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

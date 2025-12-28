{
  lib,
  config,
  ...
}: {
  options.my.localsend.enable = lib.mkEnableOption "localsend";
  config = lib.mkIf config.my.localsend.enable {
    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

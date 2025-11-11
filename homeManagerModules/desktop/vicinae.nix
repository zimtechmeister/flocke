{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];
  options.vicinae.enable = lib.mkEnableOption "enable vicinae";
  config = lib.mkIf config.vicinae.enable {
    services.vicinae = {
      enable = true;
      autoStart = true;
    };
  };
}

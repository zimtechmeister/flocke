{
  pkgs,
  lib,
  config,
  self,
  ...
}: {
  options.my.nvim.enable = lib.mkEnableOption "nvim";
  config = lib.mkIf config.my.nvim.enable {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.nvim];
  };
}

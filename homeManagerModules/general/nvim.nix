{
  pkgs,
  lib,
  config,
  self,
  ...
}: {
  options.my.nvim.enable = lib.mkEnableOption "enables home-manager for nvim";
  config = lib.mkIf config.my.nvim.enable {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.neovix];
  };
}

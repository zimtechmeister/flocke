{
  pkgs,
  lib,
  config,
  self,
  ...
}: {
  options.nvim.enable =
    lib.mkEnableOption "enables home-manager for nixBTW";

  config = lib.mkIf config.nvim.enable {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.neovix
    ];
  };
}

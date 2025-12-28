{
  pkgs,
  lib,
  config,
  self,
  ...
}: {
  options.my.nvim = {
    enable = lib.mkEnableOption "enables home-manager for nvim";
    package = lib.mkOption {
      type = lib.types.package;
      internal = true;
      description = "The neovim package to use.";
    };
  };

  config = lib.mkIf config.my.nvim.enable {
    my.nvim.package = self.packages.${pkgs.stdenv.hostPlatform.system}.neovix;
    home.packages = [config.my.nvim.package];
  };
}

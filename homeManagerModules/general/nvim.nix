{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.nvim.enable =
    lib.mkEnableOption "enables home-manager for nixBTW";

  config = lib.mkIf config.nvim.enable {
    home.packages = [
      inputs.neovix.packages.${pkgs.system}.default
    ];
  };
}

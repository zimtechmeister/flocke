{
  lib,
  config,
  pkgs,
  ...
}: {
  options.my.neovide.enable = lib.mkEnableOption "enable neovide";
  config = lib.mkIf config.my.neovide.enable {
    stylix.targets.neovide.fonts.override = {
      monospace = {
        name = "Monocraft Nerd Font";
        package = pkgs.monocraft;
      };
    };
    programs.neovide = {
      enable = true;
      # NOTE: some settings are configurd in the nvim config with lua
      settings = {
        tabs = true; # this is the default might want to change this
        vsync = true;
      };
    };
  };
}

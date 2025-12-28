{
  lib,
  config,
  ...
}: {
  options.my.neovide.enable = lib.mkEnableOption "enable neovide";
  config = lib.mkIf config.my.neovide.enable {
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

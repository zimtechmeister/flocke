{
  lib,
  config,
  ...
}: {
  options.ghostty.enable = lib.mkEnableOption "enables ghostty";
  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        font-family = "FiraCode Nerd Font";
        font-size = 12.0;
        theme = "GruvboxDark";
        cursor-color = "#d4be98";
      };
    };
  };
}

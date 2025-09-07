{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.walker.homeManagerModules.default
  ];
  options.walker.enable = lib.mkEnableOption "enable walker";
  config = lib.mkIf config.walker.enable {
    programs.walker = {
      enable = true;
      runAsService = true;

      # All options from the config.json can be used here.
      # config = {
      #   # use this as reference for this config
      #   # https://github.com/basecamp/omarchy/blob/master/config/walker/config.toml
      #   search.placeholder = "Example";
      #   ui.fullscreen = true;
      #   list = {
      #     height = 200;
      #   };
      #   websearch.prefix = "?";
      #   switcher.prefix = "/";
      # };

      # If this is not set the default styling is used.
      # theme.style = ''
      #   * {
      #     color: ${config.stylix.base16Scheme.base05};
      #   }
      # '';
    };
  };
}

{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options.anyrun.enable = lib.mkEnableOption "enable anyrun";
  config = lib.mkIf config.anyrun.enable {
    programs.anyrun = {
      enable = true;
      config = {
        x = {fraction = 0.5;};
        y = {fraction = 0.4;};
        width = {fraction = 0.4;};

        hideIcons = true;
        hidePluginInfo = true;
        layer = "overlay"; # Background, Bottom, Top, Overlay
        closeOnClick = true;
        showResultsImmediately = true;
        maxEntries = null;
        plugins = [
          inputs.anyrun.packages.${pkgs.system}.applications
          # inputs.anyrun.packages.${pkgs.system}.dictionary
          # inputs.anyrun.packages.${pkgs.system}.kidex
          # inputs.anyrun.packages.${pkgs.system}.randr
          inputs.anyrun.packages.${pkgs.system}.rink
          inputs.anyrun.packages.${pkgs.system}.shell
          # inputs.anyrun.packages.${pkgs.system}.stdin
          inputs.anyrun.packages.${pkgs.system}.symbols
          # inputs.anyrun.packages.${pkgs.system}.translate
          inputs.anyrun.packages.${pkgs.system}.websearch
        ];
      };

      extraConfigFiles."symbols.ron".text = ''
        Config(
          prefix: ":i",
          symbols: {
            "shrug": "¯\\_(ツ)_/¯",
          },
        max_entries: 3,
        )
      '';
      extraConfigFiles."randr.ron".text = ''
        Config(
          prefix: "",
          max_entries: 5,
        )
      '';
      # NOTE: the removing the Custom() makes this work dont know how to fix
      # would be nice if it works like extra symbols
      # this is what your searching for https://github.com/kuokuo123/anyrun-websearch-plus
      extraConfigFiles."websearch.ron".text = ''
        Config(
          prefix: "?",
          Custom(
            name: "Custom",
            url: "unduck.link/?q={}",
          ),
          engines: [DuckDuckGo]
        )
      '';

      # NOTE: text color is not defined
      extraCss =
        /*
        css
        */
        ''
          @define-color bg-color #${config.stylix.base16Scheme.base00};
          @define-color fg-color #${config.stylix.base16Scheme.base05};
          @define-color primary-color #${config.stylix.base16Scheme.base04};
          @define-color secondary-color #${config.stylix.base16Scheme.base0B};
          @define-color border-color @primary-color;
          @define-color selected-bg-color @primary-color;
          @define-color selected-fg-color @bg-color;
          * {
            /* reset all setings set by gtk theme */
            all: initial;
            /* font-family: JetBrainsMono Nerd Font; */
          }
          #window {
            background: transparent;
          }

          box#main {
            border-radius: 16px;
            background-color: alpha(@bg-color, 1.0);
            border: 0.5px solid alpha(@fg-color, 1.0);
          }

          entry#entry {
            font-size: 1.25rem;
            background: transparent;
            box-shadow: none;
            border: none;
            border-radius: 16px;
            padding: 16px 24px;
            min-height: 40px;
            caret-color: @primary-color;
          }

          list#main {
            background-color: transparent;
          }

          #plugin {
            background-color: transparent;
            padding-bottom: 4px;
          }

          #match {
            font-size: 1.1rem;
            padding: 2px 4px;
          }

          #match:selected,
          #match:hover {
            background-color: @selected-bg-color;
            color: @selected-fg-color;
          }

          #match:selected label#info,
          #match:hover label#info {
            color: @selected-fg-color;
          }

          #match:selected label#match-desc,
          #match:hover label#match-desc {
            color: alpha(@selected-fg-color, 1.0);
          }

          #match label#info {
            color: transparent;
            color: @fg-color;
          }

          label#match-desc {
            font-size: 1rem;
            color: @fg-color;
          }

          label#plugin {
            font-size: 16px;
          }
        '';
    };
  };
}

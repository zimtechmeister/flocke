{
  lib,
  config,
  ...
}: {
  programs.waybar.style =
    lib.mkAfter
    /*
    css
    */
    ''
      @define-color base00 #${config.stylix.base16Scheme.base00};
      @define-color base01 #${config.stylix.base16Scheme.base01};
      @define-color base02 #${config.stylix.base16Scheme.base02};
      @define-color base03 #${config.stylix.base16Scheme.base03};
      @define-color base04 #${config.stylix.base16Scheme.base04};
      @define-color base05 #${config.stylix.base16Scheme.base05};
      @define-color base06 #${config.stylix.base16Scheme.base06};
      @define-color base07 #${config.stylix.base16Scheme.base07};
      @define-color base08 #${config.stylix.base16Scheme.base08};
      @define-color base09 #${config.stylix.base16Scheme.base09};
      @define-color base0A #${config.stylix.base16Scheme.base0A};
      @define-color base0B #${config.stylix.base16Scheme.base0B};
      @define-color base0C #${config.stylix.base16Scheme.base0C};
      @define-color base0D #${config.stylix.base16Scheme.base0D};
      @define-color base0E #${config.stylix.base16Scheme.base0E};
      @define-color base0F #${config.stylix.base16Scheme.base0F};
      @define-color base10 #${config.stylix.base16Scheme.base10};
      @define-color base11 #${config.stylix.base16Scheme.base11};
      @define-color base12 #${config.stylix.base16Scheme.base12};
      @define-color base13 #${config.stylix.base16Scheme.base13};
      @define-color base14 #${config.stylix.base16Scheme.base14};
      @define-color base15 #${config.stylix.base16Scheme.base15};
      @define-color base16 #${config.stylix.base16Scheme.base16};
      @define-color base17 #${config.stylix.base16Scheme.base17};

      * {
          /* important to reset all setings set by gtk theme */
          all: initial;
          font-family: ${config.stylix.fonts.serif.name};
          font-size: 16px;
      }

      window#waybar {
          background-color: @base00;
          transition-property: background-color;
          transition-duration: .5s;
      }
      window#waybar label {
          color: @base05;
      }

      tooltip {
          background: @base00;
          border-color: @base0B;
          border-width: 0px;
          border-radius: 8px;
          border-style: solid;
      }
      tooltip label {
          color: @base05;
      }

      .module {
          padding: 0 8px;
      }

      #workspaces {
          /* border-color: @base0B; */
          /* border-width: 2px; */
          /* border-radius: 8px; */
          /* border-style: solid; */
      }
      #workspaces button {
          padding: 0 4px;
      }
      #workspaces button.visible label {
      }
      #workspaces button.empty label {
          color: @base04;
      }
      #workspaces button.active label {
      }
      #workspaces button.hosting-monitor label {
          font-weight: bold;
      }
      #workspaces button:not(.visible) label {
          color: @base05;
          font-weight: normal;
      }
      #workspaces button:hover label {
          /* box-shadow: inherit; */
          /* text-shadow: inherit; */
          color: @base02;
      }

      #tray {
          background-color: @base01;
      }
      #tray menu {
          background: @base00;
          border-width: 0px;
          border-radius: 8px;
          border-style: solid;
          padding: 8px;
      }
      #tray > .passive {
      }
      #tray > .active {
      }
      #tray > .needs-attention {
      }



      #custom-separator {
          color: @base0B;
      }

      #backlight-slider {
      }
      #backlight-slider slider {
      }
      #backlight-slider trough {
          background-color: @base02;
          min-height: 10px;
          min-width: 100px;
          border-radius: 2px;
      }
      #backlight-slider highlight {
          background-color: @base0B;
          border-radius: 2px;
      }

      #pulseaudio-slider {
      }
      #pulseaudio-slider slider {
      }
      #pulseaudio-slider trough {
          background-color: @base02;
          min-height: 10px;
          min-width: 100px;
          border-radius: 2px;
      }
      #pulseaudio-slider highlight {
          background-color: @base0B;
          border-radius: 2px;
      }
    '';
}

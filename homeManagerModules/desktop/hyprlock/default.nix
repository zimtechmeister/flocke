{
  lib,
  config,
  ...
}: {
  options.hyprlock.enable = lib.mkEnableOption "enables hyprlock";
  config = lib.mkIf config.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          ignore_empty_input = true;
        };

        background = {
          monitor = "";
          path = lib.mkForce "~/.config/wallpaper/forest-fog-grey.jpg";
          blur_passes = 0;
        };

        input-field = {
          monitor = "";
          size = "200, 40";
          outline_thickness = 0;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.4; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = lib.mkForce "rgb(${config.stylix.base16Scheme.base05})";
          inner_color = lib.mkForce "rgba(${config.stylix.base16Scheme.base00}80)";
          font_color = lib.mkForce "rgb(${config.stylix.base16Scheme.base05})";
          fade_on_empty = false;
          check_color = lib.mkForce "rgba(${config.stylix.base16Scheme.base00})";
          fail_color = lib.mkForce "rgba(${config.stylix.base16Scheme.base08})";
          fail_text = "<i><span foreground='##${config.stylix.base16Scheme.base00}'>Fail $ATTEMPTS</span></i>";
          fail_transition = 0;
          placeholder_text = "<i><span foreground='##${config.stylix.base16Scheme.base05}'>Hi, $USER</span></i>";
          hide_input = false;
          rounding = -1;
          position = "0, 0";
          halign = "center";
          valign = "center";
        };

        shape = {
          monitor = "";
          size = "400, 400";
          color = lib.mkForce "rgba(${config.stylix.base16Scheme.base00}80)";
          rounding = 8;
          border_size = 0;
          rotate = 0;
          xray = false; # if true, make a "hole" in the background (rectangle of specified size, no rotation)

          position = "0, 130";
          halign = "center";
          valign = "center";
        };

        # TIME HOUR
        label = [
          {
            monitor = "";
            text = "cmd[update:1000] echo -e $(date '+%H')";
            color = "rgb(${config.stylix.base16Scheme.base05})";
            font_size = 80;
            font_family = "${config.systemFont} Bold";
            halign = "center";
            valign = "center";
            position = "0, 235";
          }

          # TIME MINUTE
          {
            monitor = "";
            text = "cmd[update:1000] echo -e $(date '+%M')";
            color = "rgb(${config.stylix.base16Scheme.base05})";
            font_size = 80;
            font_family = "${config.systemFont} Bold";
            halign = "center";
            valign = "center";
            position = "0, 135";
          }

          # DATE
          {
            monitor = "";
            text = "cmd[update:1000] echo -e $(date '+%a %d-%m')";
            color = "rgb(${config.stylix.base16Scheme.base05})";
            font_size = 20;
            font_family = "${config.systemFont} Bold";
            halign = "center";
            valign = "center";
            position = "0, 50";
          }
        ];
      };
    };
  };
}

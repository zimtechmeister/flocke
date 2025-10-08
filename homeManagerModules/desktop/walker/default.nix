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
      # NOTE: for configoptions look here the docs are not updated yet
      # https://github.com/abenz1267/walker/blob/master/resources/config.toml
      config = {
        force_keyboard_focus = false;
        close_when_open = true;
        selection_wrap = true;
        global_argument_delimiter = "#"; # query: firefox#https://benz.dev => part after delimiter will be ignored when querying. this should be the same as in the elephant config
        keep_open_modifier = "shift";
        exact_search_prefix = "'";
        theme = "default";
        # NOTE: this does not work
        # theme.style = ''
        #   * {
        #     color: #ff00ff;
        #   }
        # '';
        disable_mouse = false;

        keybinds = {
          close = ["Escape"];
          next = ["Down"];
          previous = ["Up"];
          toggle_exact = ["ctrl e"];
          resume_last_query = ["ctrl r"];
          quick_activate = ["F1" "F2" "F3" "F4" "F5" "F6" "F7" "F8" "F9" "F10" "F11" "F12"];
        };
        providers = {
          default = [
            "desktopapplications"
            "calc"
            "websearch"
          ];
          empty = [
            "desktopapplications"
          ];
          prefixes = [
            {
              prefix = ";";
              provider = "providerlist";
            }
            {
              prefix = "/";
              provider = "files";
            }
            {
              prefix = ".";
              provider = "symbols";
            }
            {
              prefix = "!";
              provider = "todo";
            }
            {
              prefix = "=";
              provider = "calc";
            }
            {
              prefix = "@";
              provider = "websearch";
            }
            {
              prefix = ":";
              provider = "clipboard";
            }
          ];
          calc = {
            default = "copy";
            copy = "Return";
            save = "ctrl s";
            delete = "ctrl d";
          };
          websearch = {
            default = "search";
            search = "Return";
            remove_history = "ctrl BackSpace";
          };
          clipboard = {
            time_format = "%d.%m. - %H:%M"; # format for the clipboard item date
            default = "copy";
            copy = "Return";
            delete = "ctrl d";
            edit = "ctrl o";
            toggle_images_only = "ctrl i";
          };
          desktopapplications = {
            default = "start";
            start = "Return";
            remove_history = "ctrl BackSpace";
            toggle_pin = "ctrl p";
          };
          files = {
            default = "open";
            open = "Return";
            open_dir = "ctrl Return";
            copy_path = "ctrl shift C";
            copy_file = "ctrl c";
          };
          dmenu = {
            default = "select";
            select = "Return";
          };
          symbols = {
            default = "copy";
            copy = "Return";
            remove_history = "ctrl BackSpace";
          };
          unicode = {
            default = "copy";
            copy = "Return";
            remove_history = "ctrl BackSpace";
          };
          menus = {
            default = "activate";
            activate = "Return";
            remove_history = "ctrl BackSpace";
          };
        };
      };
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options.my.starship.enable =
    lib.mkEnableOption "configure starship";

  config = lib.mkIf config.my.starship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        follow_symlinks = false;
        scan_timeout = 10;

        format = ''
          $fill$directory $username[@](green)$hostname
          $character
        '';
        right_format = ''
        '';

        fill = {
          symbol = " ";
          style = "underline green";
        };

        character = {
          success_symbol = "[➜](white)";
          error_symbol = "[➜](white)";
          vimcmd_symbol = "[](green)";
          vimcmd_replace_one_symbol = "[](red)";
          vimcmd_replace_symbol = "[](red)";
          vimcmd_visual_symbol = "[](purple)";
        };

        username = {
          style_user = "white";
          style_root = "red";
          format = "[$user]($style)";
          show_always = true;
        };

        hostname = {
          format = "[$hostname]($style)";
          ssh_only = false;
          style = "white";
          trim_at = ".";
        };

        directory = {
          format = "[$read_only]($read_only_style)[$path]($style)";
          truncation_length = 4;
          truncation_symbol = "";
          truncate_to_repo = true;
          read_only = "";
          read_only_style = "red";
          style = "green";
        };
      };
    };
  };
}

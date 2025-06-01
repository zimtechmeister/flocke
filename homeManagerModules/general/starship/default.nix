{
  lib,
  config,
  ...
}: {
  options.starship.enable =
    lib.mkEnableOption "configure starship";

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = ''
          $fill$git_branch$git_status$git_metrics$fill
          $sudo$character
        '';
        right_format = ''
          $directory $username[@](green)$hostname
        '';

        scan_timeout = 10;

        fill = {
          symbol = " ";
          style = "underline green";
        };
        character = {
          success_symbol = "[➜](white)";
          error_symbol = "[➜](white)";
          vimcmd_symbol = "[](green)";
          vimcmd_replace_one_symbol = "[R](yellow)";
          vimcmd_replace_symbol = "[R](yellow)";
          vimcmd_visual_symbol = "[V](yellow)";
        };
        username = {
          style_user = "white";
          style_root = "red";
          format = "[$user]($style)";
          disabled = false;
          show_always = true;
        };

        hostname = {
          ssh_only = false;
          format = "[$hostname]($style)";
          style = "white";
          trim_at = ".";
          disabled = false;
        };

        directory = {
          format = "[$read_only]($read_only_style) [$path]($style)";
          truncation_length = 8;
          truncate_to_repo = true;
          read_only = "";
          read_only_style = "red";
          style = "green";
        };

        cmd_duration = {
          min_time = 0;
          show_milliseconds = true;
          disabled = false;
          format = "[$duration]($style)";
          style = "white";
          show_notifications = false;
          min_time_to_notify = 10000;
        };

        time = {
          disabled = false;
          format = "[$time]($style)";
          style = "white";
          time_format = "%T";
          use_12hr = false;
        };

        git_branch = {
          disabled = false;
          format = "[$symbol$branch($remote_branch)](underline green)";
        };

        git_status = {
          disabled = false;
          ignore_submodules = false;
          # format = "([ \[$all_status$ahead_behind\]](underline green))";
          format = "([ $all_status$ahead_behind](underline green))";
        };

        git_metrics = {
          disabled = false;
          only_nonzero_diffs = true;
          ignore_submodules = false;
          format = "([ +$added](underline green))([ -$deleted](underline green))";
        };

        sudo = {
          disabled = false;
          format = "[$symbol]($style)";
          symbol = "|";
          style = "green";
        };
      };
    };
  };
}

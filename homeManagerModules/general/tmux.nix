{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.my.tmux.enable =
    lib.mkEnableOption "tmux";

  config = lib.mkIf config.my.tmux.enable {
    programs = {
      tmux = {
        enable = true;
        baseIndex = 1;
        keyMode = "vi";
        mouse = true;
        clock24 = true;
        escapeTime = 0;
        historyLimit = 10000;
        terminal = "screen-256color";
        customPaneNavigationAndResize = true;
        sensibleOnTop = true;
        extraConfig = ''
          set -g renumber-windows on
          set -g status-position top
          set -g detach-on-destroy off
          set -g status-keys emacs
          set -s extended-keys on
          set -as terminal-features 'xterm*:extkeys'

          bind-key -r C-h swap-window -t -1\; select-window -t -1
          bind-key -r C-l swap-window -t +1\; select-window -t +1

          bind-key a attach-session -c "#{pane_current_path}" \; rename-session "#{pane_current_path}" \; display-message "Path synced to #{pane_current_path}"
        '';
        plugins = with pkgs; [
          {
            plugin = inputs.minimal-tmux.packages.${pkgs.stdenv.hostPlatform.system}.default;
            extraConfig = ''
              set -g @minimal-tmux-bg "#${config.stylix.base16Scheme.base05}"
              set -g @minimal-tmux-fg "#${config.stylix.base16Scheme.base00}"
              set -g @minimal-tmux-use-arrow false
            '';
          }
        ];
      };
      sesh.enable = true;
      fzf = {
        enable = true;
        tmux.enableShellIntegration = true;
      };
    };
  };
}

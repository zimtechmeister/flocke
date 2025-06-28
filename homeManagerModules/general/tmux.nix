{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.tmux.enable =
    lib.mkEnableOption "tmux";

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      keyMode = "vi";
      mouse = true;
      extraConfig = ''
        set -g renumber-windows on
        set -g set-clipboard on
        set -g status-position top

        set -g detach-on-destroy off     # don't exit from tmux when closing a session
        set -g escape-time 0             # zero-out escape time delay
        set -g history-limit 100000     # increase history size (from 2,000)
        set -g pane-active-border-style 'fg=magenta,bg=default'
        set -g pane-border-style 'fg=brightblack,bg=default'
      '';
      plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
          extraConfig = ''
            set -g @minimal-tmux-bg "#${config.stylix.base16Scheme.base05}"
            set -g @minimal-tmux-fg "#${config.stylix.base16Scheme.base00}"
            set -g @minimal-tmux-use-arrow false
          '';
        }
      ];
    };
  };
}

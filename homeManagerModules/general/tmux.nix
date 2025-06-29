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
      '';
      plugins = with pkgs; [
        tmuxPlugins.resurrect
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

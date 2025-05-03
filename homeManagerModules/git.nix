{
  lib,
  config,
  ...
}: {
  options.git.enable = lib.mkEnableOption "git";
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "Tim Zechmeister";
      userEmail = "tim.zechmeister03@gmail.com";
      extraConfig = {
        pull.rebase = "false";
        init.defaultBranch = "main";
      };
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options.my.git.enable = lib.mkEnableOption "git";
  config = lib.mkIf config.my.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Tim Zechmeister";
          email = "tim.zechmeister03@gmail.com";
        };
      };
    };
  };
}

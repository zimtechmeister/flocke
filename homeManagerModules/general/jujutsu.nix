{
  lib,
  config,
  ...
}: {
  options.my.jujutsu.enable = lib.mkEnableOption "jujutsu";
  config = lib.mkIf config.my.jujutsu.enable {
    programs.jujutsu = {
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

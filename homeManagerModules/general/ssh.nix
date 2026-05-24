{
  lib,
  config,
  ...
}: {
  options.my.ssh.enable = lib.mkEnableOption "ssh";
  config = lib.mkIf config.my.ssh.enable {
    services.ssh-agent.enable = true;
  };
}

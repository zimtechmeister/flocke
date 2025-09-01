{
  lib,
  config,
  ...
}: {
  options = {
    openssh.enable =
      lib.mkEnableOption "openssh";
  };
  config = lib.mkIf config.openssh.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
    # NOTE: when using nixos-anywhere
    # users.users.root.openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLOQ37NzU1kJ7ZIgl1t03/z7uiQ0kQ969hQ7U5nY9bY desktop"
    # ];
  };
}

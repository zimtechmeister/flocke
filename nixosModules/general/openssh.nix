{
  lib,
  config,
  ...
}: {
  options.my.openssh.enable = lib.mkEnableOption "openssh";
  config = lib.mkIf config.my.openssh.enable {
    services.fail2ban = {
      enable = true;
    };
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
      };
    };
    users.users.tim.openssh.authorizedKeys = {
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLOQ37NzU1kJ7ZIgl1t03/z7uiQ0kQ969hQ7U5nY9bY desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM9wmhtXaBDDL88/DW/yzjX2Hf37kRwWgpTFjxlg+cgL tim@t480"
      ];
      keyFiles = [];
    };
    # NOTE: when using nixos-anywhere
    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLOQ37NzU1kJ7ZIgl1t03/z7uiQ0kQ969hQ7U5nY9bY desktop"
    ];
  };
}

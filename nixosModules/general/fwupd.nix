{
  lib,
  config,
  ...
}: {
  # imports = [inputs.nix-index-database.nixosModules.nix-index];
  options.my.fwupd.enable = lib.mkEnableOption "firmware updates via fwupd";
  config = lib.mkIf config.my.fwupd.enable {
    services.fwupd.enable = true;
  };
}

{
  lib,
  config,
  ...
}: {
  options.my.zram.enable = lib.mkEnableOption "enable zram and zswap";
  config = lib.mkIf config.my.zram.enable {
    zramSwap.enable = true;
  };
}

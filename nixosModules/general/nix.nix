{
  # inputs,
  lib,
  config,
  ...
}: {
  # imports = [inputs.nix-index-database.nixosModules.nix-index];
  options.my.nix.enable = lib.mkEnableOption "nix";
  config = lib.mkIf config.my.nix.enable {
    programs = {
      # nix-index = {
      #   enable = true;
      #   enableFishIntegration = true;
      # };
      # nix-index-database.comma.enable = true;
      nh = {
        enable = true;
        # clean = {
        #   enable = true;
        #   extraArgs = "--keep 3 --keep-since 3d";
        #   dates = "hourly";
        # };
      };
    };
    environment.sessionVariables = {
      NH_FLAKE = "/home/tim/flocke";
    };
    nix = {
      gc = {
        automatic = true;
        dates = "01:00";
        randomizedDelaySec = "45min";
        persistent = true;
        options = "--delete-older-than 3d";
      };
      optimise = {
        automatic = true;
        dates = ["03:45"];
        randomizedDelaySec = "45min";
        persistent = true;
      };
    };
  };
}

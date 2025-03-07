{...} : {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  networking.hostName = "lab";
  networking.networkmanager.enable = true;
}

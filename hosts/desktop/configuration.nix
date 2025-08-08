{
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  gaming.enable = lib.mkForce true;

  networking.hostName = "desktop";

  # TODO: read home-manager docs where should it include this
  # when dooing it here i can specify which config.options to enable
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.tim = import ./home.nix;
    backupFileExtension = "hm-backup";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

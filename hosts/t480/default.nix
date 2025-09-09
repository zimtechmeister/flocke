{
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    # inputs.disko.nixosModules.default # TODO: uncomment when not in the flake.nix file
    inputs.home-manager.nixosModules.home-manager
  ];

  desktop.enable = lib.mkForce true;
  bluetooth.enable = lib.mkForce true;

  networking.hostName = "t480";

  home-manager = {
    users.tim = {
      imports = [
        inputs.self.outputs.homeManagerModules.default
        ./home.nix
      ];
    };
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "hm-backup";
    useUserPackages = true;
    useGlobalPkgs = true;
  };
}

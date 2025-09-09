{
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # ./disko.nix
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  desktop.enable = lib.mkForce false;
  bluetooth.enable = lib.mkForce false;
  server.enable = lib.mkForce true;

  networking.hostName = "optiplex3000";

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

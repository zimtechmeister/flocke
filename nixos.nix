{
  inputs,
  self,
  ...
}: {
  flake = let
    mkSystem = {
      hostname,
      extraModules ? [],
    }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs self;};
        modules =
          [
            # imports = [];
            # all this could also be done in imports in ./hosts/desktop/default.nix
            self.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix

            ./hosts/${hostname}

            {
              networking.hostName = hostname;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-backup";
                extraSpecialArgs = {inherit inputs self;};

                users.tim = {
                  imports = [
                    self.homeManagerModules.default
                  ];
                };
              };
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      desktop = mkSystem {
        hostname = "desktop";
      };

      optiplex3000 = mkSystem {
        hostname = "optiplex3000";
      };

      t480 = mkSystem {
        hostname = "t480";
        extraModules = [inputs.disko.nixosModules.disko];
      };
    };

    nixosModules.default = ./nixosModules;
    homeManagerModules.default = ./homeManagerModules;

    homeConfigurations."tim" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs self;};
      modules = [
        self.homeManagerModules.default
        inputs.stylix.homeModules.stylix
        # stylix has problems with home-manager if not imported here too
        ./nixosModules/stylix.nix
      ];
    };
  };
}

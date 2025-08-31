{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovix = {
      url = "github:zimtechmeister/neovix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland.follows = "hyprland";
    };

    niri = {
      # TODO: deprecated
      url = "github:sodiboo/niri-flake";
    };

    anyrun = {
      # TODO: deprecated
      url = "github:anyrun-org/anyrun";
    };

    zen-browser = {
      # TODO: deprecated
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minimal-tmux = {
      # TODO: deprecated
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # TODO: add minimal config as outputs to flash to usb
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          stylix.nixosModules.stylix
          ./hosts/desktop/configuration.nix
          ./nixosModules
        ];
      };

      # Add this line in modules for better hardware support https://github.com/NixOS/nixos-hardware
      # nixos-hardware.nixosModules.lenovo-thinkpad-t480
      # I don't know if I should then remove the hardwareconfiguration.nix file
      # take care what happens to the boot configuration
      t480 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          # TODO: can i do this sylix thing in the stylix.nix file?
          inputs.stylix.nixosModules.stylix
          inputs.disko.nixosModules.default
          # TODO: could rename to default to only import ./hosts/t480/
          ./hosts/t480/configuration.nix
          ./nixosModules
          {
            # TODO: enable and disable your nixos config options here
            # programs.zsh.enable = true;
          }

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.tim = {
                imports = [
                  ./hosts/t480/home.nix
                  # inputs.self.outputs.homeManagerModules.default
                ];
                # TODO: enable and disable your home-manager config options here
              };
              extraSpecialArgs = {inherit inputs;};
              backupFileExtension = "hm-backup";
              useUserPackages = true;
              useGlobalPkgs = true;
            };
          }
        ];
      };
      optiplex3000 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          stylix.nixosModules.stylix
          ./hosts/optiplex3000/configuration.nix
          ./nixosModules
          inputs.self.outputs.nixosModules.default
        ];
      };
    };
    nixosModules.default = ./nixosModules;
    homeManagerModules.default = ./homeManagerModules;
    # TODO:
    # this is for lsp
    # in nix repl
    # :lf /home/tim/nixos
    # builtins.attrNames (builtins.getFlake "/home/tim/nixos").nixosConfigurations.desktop
    # builtins.attrNames (builtins.getFlake "/home/tim/nixos").homeConfigurations.tim-home
    homeConfigurations = {
      "tim" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/desktop/home.nix
        ];
      };
    };
  };
}

{
  description = "Nixos config flake";

  inputs = {
    #TODO: which url is what "github:nixos/nixpkgs/nixpkgs-unstable"
    # this one is default at nix flake init"github:nixos/nixpkgs?ref=nixos-unstable"
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcats.url = "github:zimtechmeister/nixCats.nvim";

    hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      #TODO: rename PC to desktop
      PC = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/PC/configuration.nix
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
          ./hosts/t480/configuration.nix
          ./nixosModules
        ];
      };
    };
    # NOTE:
    # this is for lsp
    # in nix repl
    # :lf /home/tim/nixos
    # builtins.attrNames (builtins.getFlake "/home/tim/nixos").nixosConfigurations.PC
    # builtins.attrNames (builtins.getFlake "/home/tim/nixos").homeConfigurations.tim-home
    homeConfigurations = {
      "tim" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./hosts/PC/home.nix
        ];
      };
    };
  };
}

{
  self,
  inputs,
  ...
}: {
  # This is your system configuration entry-point
  flake.nixosConfigurations.HOSTNAME = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.HOSTNAMEModule
    ];
  };

  # This is your configuration.nix, a place where you configure your system
  # You can place it in a separate file.
  flake.nixosModules.HOSTNAMEModule = {pkgs, ...}: {
    imports = [
      inputs.home-manager.nixosModules.default # import official home-manager NixOS module
    ];
    users.users.USERNAME = {
      # create user
      isNormalUser = true;
      shell = pkgs.fish;
    };
    home-manager.users.USERNAME = self.homeModules.USERNAMEModule; # enable home-manager for user

    environment.systemPackages = [
      pkgs.vim
      pkgs.firefox
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported in your nixos configuration above, and also used in a standalone configuration below
  flake.homeModules.USERNAMEModule = {pkgs, ...}: {
    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";

    home.packages = [pkgs.hello];
    home.stateVersion = "24.11";
  };
}

{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    system,
    ...
  }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    packages.neovix = import ./packages/neovim {
      inherit pkgs;
      inherit inputs;
    };
    apps.neovix = {
      type = "app";
      program = "${self'.packages.neovix}/bin/nvim";
    };
    devShells.neovix = pkgs.mkShell {
      buildInputs = [self'.packages.neovix];
    };
  };
}

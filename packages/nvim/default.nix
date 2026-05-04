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
    packages.nvim = import ./wrapper.nix {
      inherit pkgs;
      inherit inputs;
    };
    apps.nvim = {
      type = "app";
      program = "${pkgs.lib.getExe' self'.packages.nvim "nvim"}";
    };
    devShells.nvim = pkgs.mkShell {
      buildInputs = [self'.packages.nvim];
    };
  };
}

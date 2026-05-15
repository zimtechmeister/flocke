{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    lib,
    ...
  }: {
    packages.nvim = import ./wrapper.nix {
      inherit pkgs;
      inherit inputs;
    };
    apps.nvim = {
      type = "app";
      program = lib.getExe self'.packages.nvim;
    };
    devShells.nvim = pkgs.mkShell {
      buildInputs = [self'.packages.nvim];
    };
  };
}

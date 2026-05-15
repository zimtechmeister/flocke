{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    self',
    ...
  }: {
    packages.hyprland = pkgs.callPackage ./wrapper.nix {
      inherit inputs;
    };
    packages.xdg-desktop-portal-hyprland = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    devShells.hyprland = pkgs.mkShell {
      buildInputs = [self'.packages.hyprland];
    };
  };
}

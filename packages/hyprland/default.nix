{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    self',
    theme,
    ...
  }: {
    packages.hyprland = pkgs.callPackage ./wrapper.nix {
      inherit inputs theme;
    };
    packages.xdg-desktop-portal-hyprland = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    devShells.hyprland = pkgs.mkShell {
      buildInputs = [self'.packages.hyprland];
    };
  };
}

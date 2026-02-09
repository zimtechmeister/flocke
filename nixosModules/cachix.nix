# If you want to use the cache do not add inputs.nixpkgs.follows = "nixpkgs";
# to your flake! This will make the cache miss.
{
  nix.settings = {
    trusted-users = [
      "root"
      "tim"
      "@wheel"
    ];
    substituters = [
      "https://hyprland.cachix.org"
      "https://niri.cachix.org"
      "https://vicinae.cachix.org"

      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="

      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}

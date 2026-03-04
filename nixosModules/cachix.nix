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
      # "https://niri.cachix.org"

      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      # "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="

      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}

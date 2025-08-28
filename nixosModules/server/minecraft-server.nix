{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  options = {
    minecraft-server.enable = lib.mkEnableOption "minecraft-server";
  };
  config = lib.mkIf config.minecraft-server.enable {
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      servers = {
        vanilla-test = {
          enable = true;
          jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
          package = pkgs.fabricServers.fabric-1_21_8;
        };
        cool-server1 = {
          enable = false;
          jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";

          package = pkgs.fabricServers.fabric-1_21_1.override {loaderVersion = "0.16.10";};

          symlinks = {
            mods = pkgs.linkFarmFromDrvs "mods" (
              builtins.attrValues {
                Fabric-API = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/9YVrKY0Z/fabric-api-0.115.0%2B1.21.1.jar";
                  sha512 = "e5f3c3431b96b281300dd118ee523379ff6a774c0e864eab8d159af32e5425c915f8664b1cd576f20275e8baf995e016c5971fea7478c8cb0433a83663f2aea8";
                };
                Backpacks = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/MGcd6kTf/versions/Ci0F49X1/1.2.1-backpacks_mod-1.21.2-1.21.3.jar";
                  sha512 = "6efcff5ded172d469ddf2bb16441b6c8de5337cc623b6cb579e975cf187af0b79291b91a37399a6e67da0758c0e0e2147281e7a19510f8f21fa6a9c14193a88b";
                };
              }
            );
          };
        };
        modpack-server1 = {
          enable = false;
          jvmOpts = "-Xmx4G -Xms2G";

          package = pkgs.fabricServers.fabric-1_18_2.override {loaderVersion = "0.14.9";};

          symlinks = let
            modpack = pkgs.fetchPackwizModpack {
              url = "https://github.com/Misterio77/Modpack/raw/0.2.9/pack.toml";
              packHash = "sha256-L5RiSktqtSQBDecVfGj1iDaXV+E90zrNEcf4jtsg+wk=";
            };
          in {
            mods = "${modpack}/mods";
          };
        };
      };
    };
  };
}

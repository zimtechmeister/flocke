{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../../homeManagerModules
  ];

  hyprland.monitorLayout =
    lib.mkDefault "PC";
  waybar.config =
    lib.mkDefault "PC";

  programs = {
    git = {
      enable = true;
      userName = "Tim Zechmeister";
      userEmail = "tim.zechmeister03@gmail.com";
      # dont know if this works
      extraConfig = {
        pull.rebase = "false";
      };
    };
  };
}

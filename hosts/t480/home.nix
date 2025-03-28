{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.self.outputs.homeManagerModules.default
  ];

  hyprland.monitorLayout =
    lib.mkDefault "t480";
 
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

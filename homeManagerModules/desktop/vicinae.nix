{
  inputs,
  # pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];
  options.vicinae.enable = lib.mkEnableOption "enable vicinae";
  config = lib.mkIf config.vicinae.enable {
    home.sessionVariables = {
      EMOJI_FONT = "Noto Color Emoji";
    };
    services.vicinae = {
      enable = true;
      autoStart = true;
      settings = {
        faviconService = "twenty"; # twenty | google | none
        font.size = config.stylix.fonts.sizes.applications;
        popToRootOnClose = false;
        rootSearch.searchFiles = false;
        theme.name = "gruvbox-dark";
        window = {
          csd = false;
          opacity = 1;
        };
      };
      extensions = [
        # (inputs.vicinae.mkVicinaeExtension.${pkgs.system} {
        #   inherit pkgs;
        #   name = "extension-name";
        #   src = pkgs.fetchFromGitHub {
        #     # You can also specify different sources other than github
        #     owner = "repo-owner";
        #     repo = "repo-name";
        #     rev = "v1.0"; # If the extension has no releases use the latest commit hash
        #     # You can get the sha256 by rebuilding once and then copying the output hash from the error message
        #     sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        #   }; # If the extension is in a subdirectory you can add ` + "/subdir"` between the brace and the semicolon here
        # })
      ];
    };
  };
}

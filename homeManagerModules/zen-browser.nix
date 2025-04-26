{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.zen-browser.enable =
    lib.mkEnableOption "enables home-manager for nixBTW";

  imports = [
    inputs.zen-browser.homeModules.default
  ];
  config = lib.mkIf config.zen-browser.enable {
    # NOTE: can be configured just like firefox
    # ask where to download to
    # unduck default search also private window
    # dns settings https://adblock.dns.mullvad.net/dns-query
    # ask to save passwords
    nixpkgs.config.allowUnfree = true;
    programs.zen-browser = {
      enable = true;
      languagePacks = ["de" "en-US"];
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DontCheckDefaultBrowser = true;
        # DNSOverHTTPS
        # Extension
        # ExtensionSettings
        # Preferences
        # SearchEngines
      };
      profiles.tim = {
        isDefault = true;
        extensions = with inputs.firefox-addons.packages."${pkgs.system}"; [
          bitwarden
          ublock-origin
          sponsorblock
          darkreader
          return-youtube-dislikes
          vimium
          youtube-nonstop
          # NOTE: i somehow need to allowUnfree packages
          # enhancer-for-youtube
        ];
        search.engines = {
          "Unduck" = {
            urls = [
              {
                template = "https://unduck.link?q=%s";
              }
            ];
            definedAliases = ["@ud"];
          };
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packaegs";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@np"];
          };
        };
        search.force = true;
      };
    };
  };
}

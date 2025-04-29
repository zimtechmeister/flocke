{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.zen-browser.enable =
    lib.mkEnableOption "enables zen-browser";

  imports = [
    inputs.zen-browser.homeModules.default
  ];
  config = lib.mkIf config.zen-browser.enable {
    # NOTE: can be configured just like firefox
    programs.zen-browser = {
      enable = true;
      languagePacks = ["de" "en-US"];
      profiles.tim = {
        isDefault = true;
        # NOTE: list of available plugins: https://nur.nix-community.org/repos/rycee/
        extensions.packages = with inputs.firefox-addons.packages."${pkgs.system}"; [
          bitwarden
          ublock-origin
          sponsorblock
          darkreader
          return-youtube-dislikes
          vimium
          youtube-nonstop
          refined-github
          # NOTE: i somehow need to allowUnfree packages? (its already set)
          # enhancer-for-youtube
          (enhancer-for-youtube.overrideAttrs (o: {
            meta = o.meta // {license = lib.licenses.mit;};
          }))
          # also dont know how to configure plugins
        ];
        settings = {
          "network.trr.mode" = 2;
          "network.trr.uri" = "https://adblock.dns.mullvad.net/dns-query";
          "network.trr.custom_uri" = "https://adblock.dns.mullvad.net/dns-query";
          "browser.download.useDownloadDir" = false;
          "general.autoScroll" = true;
          "signon.rememberSignons" = false;
          "browser.search.suggest.enabled" = true;
          "sidebar.position_start" = false;
          "zen.urlbar.behavior" = "float";
          "zen.theme.color-prefs.use-workspace-colors" = false;
          "zen.view.compact.color-sidebar" = false;
          "zen.view.compact.color-toolbar" = false;
          "zen.view.show-newtab-button-top" = false;
        };
        search = {
          default = "Unduck";
          privateDefault = "Unduck";
          engines = {
            "Unduck" = {
              urls = [
                {
                  template = "https://unduck.link";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@ud"];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
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
          force = true;
        };
      };
    };
  };
}

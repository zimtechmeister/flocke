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
        extensions.packages = with inputs.firefox-addons.packages."${pkgs.system}"; let
          # could not fix an allowUnfree error -> so this hack fixes it
          enhancer-for-youtube = inputs.firefox-addons.packages."${pkgs.system}".enhancer-for-youtube.overrideAttrs (old: {
            meta = old.meta // {license.free = true;};
          });
        in [
          bitwarden
          ublock-origin
          sponsorblock
          darkreader
          return-youtube-dislikes
          vimium
          youtube-nonstop
          refined-github
          enhancer-for-youtube
        ];
        settings = {
          "browser.shell.checkDefaultBrowser" = false;
          "browser.download.useDownloadDir" = false;
          "general.autoScroll" = true;
          "signon.rememberSignons" = false;
          "browser.search.suggest.enabled" = true;
          "network.trr.mode" = 2;
          "network.trr.uri" = "https://adblock.dns.mullvad.net/dns-query";
          "network.trr.custom_uri" = "https://adblock.dns.mullvad.net/dns-query";
          "sidebar.position_start" = false;
          "browser.tabs.insertAfterCurrent" = true;
          "browser.translations.automaticallyPopup" = false;
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
                      name = "channel";
                      value = "unstable";
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
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@no"];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "release";
                      value = "master";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@hmo"];
            };
          };
          force = true;
        };
      };
    };
  };
}

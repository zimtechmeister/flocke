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
          youtube-nonstop # does this even work?
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
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "network.trr.uri" = "https://adblock.dns.mullvad.net/dns-query";
          "network.trr.custom_uri" = "https://adblock.dns.mullvad.net/dns-query";
          "sidebar.position_start" = false;
          "browser.tabs.insertAfterCurrent" = true;
          "browser.translations.automaticallyPopup" = false;
          "zen.urlbar.behavior" = "float";
          "zen.theme.accent-color" = "#${config.stylix.base16Scheme.base05}";
          "zen.theme.color-prefs.use-workspace-colors" = false;
          "zen.view.compact.toolbar-flash-popup" = true;
          "zen.view.compact.color-sidebar" = false;
          "zen.view.compact.color-toolbar" = false;
          "zen.tabs.show-newtab-vertical" = false;
          "zen.theme.content-element-separation" = 0; # remove border
          "zen.view.experimental-no-window-controls" = true;
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

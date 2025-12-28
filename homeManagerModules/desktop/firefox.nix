{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.my.firefox.enable = lib.mkEnableOption "enables firefox";

  config = lib.mkIf config.my.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = ["de" "en-US"];
      profiles.tim = {
        isDefault = true;
        extensions.packages = with inputs.firefox-addons.packages."${pkgs.stdenv.hostPlatform.system}"; let
          # could not fix an allowUnfree error -> so this hack fixes it
          improved-tube = inputs.firefox-addons.packages."${pkgs.stdenv.hostPlatform.system}".improved-tube.overrideAttrs (old: {
            meta = old.meta // {license.free = true;};
          });
          languagetool = inputs.firefox-addons.packages."${pkgs.stdenv.hostPlatform.system}".languagetool.overrideAttrs (old: {
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
          improved-tube
          languagetool
        ];
        settings = {
          "browser.startup.page" = 3; # Open previous windows and tabs
          "browser.shell.checkDefaultBrowser" = false; # Always check if Firefox is your default browser
          "browser.download.useDownloadDir" = false; # Always ask you where to save files
          # play drm controlled content
          "general.autoScroll" = true; # Use autoscrolling
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false; # Recommend extensions as you browse
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false; # Recommend features as you browse

          # "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          # "browser.newtabpage.activity-stream.system.showSponsored" = false;
          # "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
          # "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # "browser.newtabpage.activity-stream.feeds.trendingsearchfeed" = false;
          "browser.search.suggest.enabled" = true; # Show search suggestions
          "browser.urlbar.suggest.trending" = true; # Show trending searches in address bar true is default

          "signon.rememberSignons" = false; # Ask to save passwords
          "extensions.formautofill.addresses.enabled" = false; # Save and fill addresses
          "extensions.formautofill.creditCards.enabled" = false; # Save and fill payment methods
          "network.trr.mode" = 2;
          "network.trr.uri" = "https://adblock.dns.mullvad.net/dns-query";
          "network.trr.custom_uri" = "https://adblock.dns.mullvad.net/dns-query";

          "browser.tabs.inTitlebar" = 0;
          "browser.tabs.insertAfterCurrent" = true;
          "browser.translations.automaticallyPopup" = false;

          "sidebar.verticalTabs" = true;
          "sidebar.position_start" = true;

          # TODO: secrets
          # "services.sync.username" = "";
          "services.sync.declinedEngines" = "passwords,creditcards,prefs,addresses,workspaces";
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
    stylix.targets.firefox.profileNames = ["tim"];
  };
}

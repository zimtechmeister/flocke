{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];
  options.my.noctalia.enable = lib.mkEnableOption "enables noctalia";
  config = lib.mkIf config.my.noctalia.enable {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
      settings = {
        settingsVersion = 37;
        appLauncher = {
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          enableClipPreview = true;
          enableClipboardHistory = true;
          iconMode = "tabler";
          ignoreMouseInput = false;
          pinnedExecs = [];
          position = "center";
          screenshotAnnotationTool = "satty -f";
          showCategories = false;
          showIconBackground = true;
          sortByMostUsed = true;
          terminalCommand = "ghostty -e";
          useApp2Unit = false;
          viewMode = "list";
        };
        audio = {
          cavaFrameRate = 30;
          externalMixer = "pwvucontrol || pavucontrol";
          mprisBlacklist = [];
          preferredPlayer = "";
          visualizerType = "mirrored";
          volumeOverdrive = false;
          volumeStep = 5;
        };
        bar = {
          backgroundOpacity = 1.0;
          capsuleOpacity = 1.0;
          density = "default";
          exclusive = true;
          floating = false;
          marginHorizontal = 0.25;
          marginVertical = 0.25;
          monitors = [];
          outerCorners = false;
          position = "top";
          showCapsule = true;
          showOutline = false;
          useSeparateOpacity = false;
          widgets = {
            center = [
              {
                customFont = "";
                formatHorizontal = "HH:mm - ddd, MMM dd";
                formatVertical = "HH mm - dd MM";
                id = "Clock";
                tooltipFormat = "HH:mm:ss - ddd, MMM dd";
                useCustomFont = false;
                usePrimaryColor = false;
              }
            ];
            left = [
              {
                characterCount = 2;
                colorizeIcons = false;
                enableScrollWheel = true;
                followFocusedScreen = false;
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconScale = 0.8;
                id = "Workspace";
                labelMode = "index";
                showApplications = false;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 1;
              }
            ];
            right = [
              {
                hideMode = "hidden";
                hideWhenIdle = false;
                id = "MediaMini";
                maxWidth = 145;
                scrollingMode = "hover";
                showAlbumArt = false;
                showArtistFirst = true;
                showProgressRing = true;
                showVisualizer = false;
                useFixedWidth = false;
                visualizerType = "wave";
              }
              {
                blacklist = [];
                colorizeIcons = false;
                drawerEnabled = true;
                hidePassive = false;
                id = "Tray";
                pinned = [];
              }
              {
                hideWhenZero = false;
                id = "NotificationHistory";
                showUnreadBadge = true;
              }
              {
                compactMode = false;
                diskPath = "/";
                id = "SystemMonitor";
                showCpuTemp = false;
                showCpuUsage = true;
                showDiskUsage = false;
                showGpuTemp = false;
                showLoadAverage = false;
                showMemoryAsPercent = false;
                showMemoryUsage = true;
                showNetworkStats = false;
                useMonospaceFont = false;
                usePrimaryColor = false;
              }
              {
                displayMode = "alwaysShow";
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
                warningThreshold = 30;
              }
              {
                colorizeDistroLogo = false;
                colorizeSystemIcon = "none";
                customIconPath = "";
                enableColorization = false;
                icon = "snowflake";
                id = "ControlCenter";
                useDistroLogo = true;
              }
            ];
          };
        };
        brightness = {
          brightnessStep = 5;
          enableDdcSupport = false;
          enforceMinimum = true;
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "timer-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        colorSchemes = {
          darkMode = true;
          generateTemplatesForPredefined = false;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          matugenSchemeType = "scheme-fruit-salad";
          predefinedScheme = "Gruvbox";
          schedulingMode = "off";
          useWallpaperColors = false;
        };
        controlCenter = {
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "brightness-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
          diskPath = "/";
          position = "close_to_bar_button";
          shortcuts = {
            left = [
              {id = "WiFi";}
              {id = "Bluetooth";}
              {id = "PowerProfile";}
            ];
            right = [
              {id = "WallpaperSelector";}
              {id = "KeepAwake";}
              {id = "NightLight";}
            ];
          };
        };
        desktopWidgets = {
          enabled = false;
          gridSnap = false;
          monitorWidgets = [];
        };
        dock = {
          animationSpeed = 1;
          backgroundOpacity = 1.0;
          colorizeIcons = false;
          deadOpacity = 0.6;
          displayMode = "auto_hide";
          enabled = false;
          floatingRatio = 1;
          inactiveIndicators = false;
          monitors = [];
          onlySameOutput = true;
          pinnedApps = [];
          pinnedStatic = false;
          size = 1;
        };
        general = {
          allowPanelsOnScreenWithoutBar = true;
          animationDisabled = false;
          animationSpeed = 1;
          avatarImage = "/home/tim/.face";
          boxRadiusRatio = 1;
          compactLockScreen = false;
          dimmerOpacity = 0.2;
          enableShadows = false;
          forceBlackScreenCorners = false;
          iRadiusRatio = 1;
          language = "";
          lockOnSuspend = true;
          radiusRatio = 1;
          scaleRatio = 1;
          screenRadiusRatio = 1;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          showHibernateOnLockScreen = false;
          showScreenCorners = false;
          showSessionButtonsOnLockScreen = true;
        };
        hooks = {
          darkModeChange = "";
          enabled = false;
          performanceModeDisabled = "";
          performanceModeEnabled = "";
          screenLock = "";
          screenUnlock = "";
          wallpaperChange = "";
        };
        location = {
          analogClockInCalendar = false;
          firstDayOfWeek = 1;
          name = "butzbach";
          showCalendarEvents = true;
          showCalendarWeather = true;
          showWeekNumberInCalendar = true;
          use12hourFormat = false;
          useFahrenheit = false;
          weatherEnabled = true;
          weatherShowEffects = true;
        };
        network = {
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          bluetoothRssiPollIntervalMs = 10000;
          bluetoothRssiPollingEnabled = false;
          wifiDetailsViewMode = "grid";
          wifiEnabled = true;
        };
        nightLight = {
          autoSchedule = true;
          dayTemp = "6500";
          enabled = true;
          forced = false;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          nightTemp = "4000";
        };
        notifications = {
          backgroundOpacity = 1.0;
          criticalUrgencyDuration = 15;
          enableKeyboardLayoutToast = true;
          enabled = true;
          location = "top_right";
          lowUrgencyDuration = 3;
          monitors = [];
          normalUrgencyDuration = 8;
          overlayLayer = true;
          respectExpireTimeout = false;
          saveToHistory = {
            critical = true;
            low = true;
            normal = true;
          };
          sounds = {
            criticalSoundFile = "";
            enabled = false;
            excludedApps = "";
            lowSoundFile = "";
            normalSoundFile = "";
            separateSounds = false;
            volume = 0.5;
          };
        };
        osd = {
          autoHideMs = 2000;
          backgroundOpacity = 1.0;
          enabled = true;
          enabledTypes = [0 2 4 3];
          location = "top";
          monitors = [];
          overlayLayer = true;
        };
        screenRecorder = {
          audioCodec = "opus";
          audioSource = "default_output";
          colorRange = "limited";
          copyToClipboard = false;
          directory = "/home/tim/Videos";
          frameRate = 60;
          quality = "very_high";
          showCursor = true;
          videoCodec = "h264";
          videoSource = "portal";
        };
        sessionMenu = {
          countdownDuration = 2000;
          enableCountdown = true;
          largeButtonsLayout = "grid";
          largeButtonsStyle = true;
          position = "center";
          powerOptions = [
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
            {
              action = "lock";
              command = "";
              countdownEnabled = false;
              enabled = true;
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
          ];
          showHeader = true;
          showNumberLabels = true;
        };
        systemMonitor = {
          cpuCriticalThreshold = 90;
          cpuPollingInterval = 3000;
          cpuWarningThreshold = 80;
          criticalColor = "";
          diskCriticalThreshold = 90;
          diskPollingInterval = 3000;
          diskWarningThreshold = 80;
          enableDgpuMonitoring = false;
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
          gpuCriticalThreshold = 90;
          gpuPollingInterval = 3000;
          gpuWarningThreshold = 80;
          loadAvgPollingInterval = 3000;
          memCriticalThreshold = 90;
          memPollingInterval = 3000;
          memWarningThreshold = 80;
          networkPollingInterval = 3000;
          tempCriticalThreshold = 90;
          tempPollingInterval = 3000;
          tempWarningThreshold = 80;
          useCustomColors = false;
          warningColor = "";
        };
        templates = {
          alacritty = false;
          cava = false;
          code = false;
          discord = false;
          emacs = false;
          enableUserTemplates = false;
          foot = false;
          fuzzel = false;
          ghostty = false;
          gtk = false;
          helix = false;
          hyprland = false;
          kcolorscheme = false;
          kitty = false;
          mango = false;
          niri = false;
          pywalfox = false;
          qt = false;
          spicetify = false;
          telegram = false;
          vicinae = false;
          walker = false;
          wezterm = false;
          yazi = false;
          zed = false;
        };
        ui = {
          boxBorderEnabled = false;
          fontDefault = "${config.stylix.fonts.serif.name}";
          fontDefaultScale = 1;
          fontFixed = "${config.stylix.fonts.monospace.name}";
          fontFixedScale = 1;
          panelBackgroundOpacity = 1.0;
          panelsAttachedToBar = true;
          settingsPanelMode = "attached";
          tooltipsEnabled = true;
        };
        wallpaper = {
          directory = "/home/tim/.config/wallpaper"; # TODO: bad
          enableMultiMonitorDirectories = false;
          enabled = true;
          fillColor = "#000000";
          fillMode = "crop";
          hideWallpaperFilenames = false;
          monitorDirectories = [];
          overviewEnabled = false;
          panelPosition = "follow_bar";
          randomEnabled = false;
          randomIntervalSec = 300;
          recursiveSearch = true;
          setWallpaperOnAllMonitors = true;
          solidColor = "#1a1a2e";
          transitionDuration = 1500;
          transitionEdgeSmoothness = 0.05;
          transitionType = "random";
          useSolidColor = false;
          useWallhaven = false;
          wallhavenApiKey = "";
          wallhavenCategories = "111";
          wallhavenOrder = "desc";
          wallhavenPurity = "100";
          wallhavenQuery = "";
          wallhavenRatios = "";
          wallhavenResolutionHeight = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenSorting = "relevance";
          wallpaperChangeMode = "random";
        };
      };
    };
    # home.file.".config/noctalia/plugins" = {
    #   recursive = true;
    #   source = pkgs.fetchFromGitHub {
    #     owner = "noctalia-dev";
    #     repo = "noctalia-plugins";
    #     rev = "e41dffb965ccb3c2b1e3a69a5bf153c99525e26a";
    #     hash = "sha256-L8t/nY5/lORGqEtubx/34uSbGyWkQfadGom7w8AZznI=";
    #     sparseCheckout = [
    #       "mangowc-layout-switcher"
    #       "privacy-indicator"
    #     ];
    #   };
    # };
    # home.file.".config/noctalia/plugins/privacy-indicator/settings.json" = {
    #   text = builtins.toJSON {
    #     hideInactive = true;
    #     iconSpacing = 4;
    #     removeMargins = false;
    #   };
    # };
    # home.file.".config/noctalia/plugins.json" = {
    #   text = builtins.toJSON {
    #     sources = [
    #       {
    #         enabled = true;
    #         name = "Official Noctalia Plugins";
    #         url = "https://github.com/noctalia-dev/noctalia-plugins";
    #       }
    #     ];
    #     states = {
    #       mangowc-layout-switcher = {
    #         enabled = true;
    #       };
    #       privacy-indicator = {
    #         enabled = true;
    #       };
    #     };
    #   };
    # };
  };
}

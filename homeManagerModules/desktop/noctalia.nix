{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];
  options.my.noctalia.enable = lib.mkEnableOption "enables noctalia";
  config = lib.mkIf config.my.noctalia.enable {
    # NOTE: evolution-data-server must be enabled at the NixOS level for calendar events
    programs.noctalia-shell = {
      enable = true;
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {calendarSupport = true;};
      systemd.enable = true;
      # NOTE: create these settings with
      #       noctalia-shell ipc call state all > somefile.json
      #       and convert to nix with
      #       nix eval --impure --expr 'builtins.fromJSON (builtins.readFile ./somefile.json)' > someotherfil.nix
      #       only small small manual changes are required after that
      #       opacity settings need to be 1.0 not 1
      settings = {
        appLauncher = {
          autoPasteClipboard = false;
          clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store"; # TODO: nixify
          clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store"; # TODO: nixify
          clipboardWrapText = true;
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          density = "compact";
          enableClipPreview = true;
          enableClipboardChips = true;
          enableClipboardHistory = true;
          enableClipboardSmartIcons = true;
          enableSessionSearch = true;
          enableSettingsSearch = true;
          enableWindowsSearch = true;
          iconMode = "tabler";
          ignoreMouseInput = false;
          overviewLayer = false;
          pinnedApps = [];
          position = "follow_bar";
          screenshotAnnotationTool = "satty -f"; # TODO: nixify
          showCategories = true;
          showIconBackground = true;
          sortByMostUsed = true;
          terminalCommand = "ghostty -e"; # TODO: nixify
          viewMode = "list";
        };
        audio = {
          mprisBlacklist = [];
          preferredPlayer = "";
          spectrumFrameRate = 30;
          spectrumMirrored = true;
          visualizerType = "mirrored";
          volumeFeedback = true;
          volumeFeedbackSoundFile = "";
          volumeOverdrive = true;
          volumeStep = 5;
        };
        bar = {
          autoHideDelay = 500;
          autoShowDelay = 150;
          backgroundOpacity = 1.0;
          barType = "floating";
          capsuleColorKey = "none";
          capsuleOpacity = 1.0;
          contentPadding = 2;
          density = "default";
          displayMode = "non_exclusive";
          enableExclusionZoneInset = true;
          fontScale = 1;
          frameRadius = 12;
          frameThickness = 8;
          hideOnOverview = false;
          marginHorizontal = 10;
          marginVertical = 10;
          middleClickAction = "none";
          middleClickCommand = "";
          middleClickFollowMouse = false;
          monitors = [];
          mouseWheelAction = "none";
          mouseWheelWrap = true;
          outerCorners = false;
          position = "right";
          reverseScroll = false;
          rightClickAction = "controlCenter";
          rightClickCommand = "";
          rightClickFollowMouse = true;
          screenOverrides = [];
          showCapsule = true;
          showOnWorkspaceSwitch = true;
          showOutline = false;
          useSeparateOpacity = true;
          widgetSpacing = 6;
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
                groupedBorderOpacity = 1.0;
                hideUnoccupied = true;
                iconScale = 0.8;
                id = "Workspace";
                labelMode = "index";
                showApplications = false;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 1.0;
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
                deviceNativePath = "__default__";
                displayMode = "graphic";
                hideIfIdle = false;
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
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
          backlightDeviceMappings = [];
          brightnessStep = 5;
          enableDdcSupport = true;
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
          generationMethod = "tonal-spot";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          monitorForColors = "";
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
          gridSnapScale = false;
          monitorWidgets = [];
          overviewEnabled = true;
        };
        dock = {
          animationSpeed = 1;
          backgroundOpacity = 1.0;
          colorizeIcons = false;
          deadOpacity = 0.6;
          displayMode = "auto_hide";
          dockType = "floating";
          enabled = false;
          floatingRatio = 1;
          groupApps = false;
          groupClickAction = "cycle";
          groupContextMenuMode = "extended";
          groupIndicatorStyle = "dots";
          inactiveIndicators = false;
          indicatorColor = "primary";
          indicatorOpacity = 0.6;
          indicatorThickness = 3;
          launcherIcon = "";
          launcherIconColor = "none";
          launcherPosition = "end";
          launcherUseDistroLogo = false;
          monitors = [];
          onlySameOutput = true;
          pinnedApps = [];
          pinnedStatic = false;
          position = "bottom";
          showDockIndicator = false;
          showLauncherIcon = false;
          sitOnFrame = false;
          size = 1;
        };
        general = {
          allowPanelsOnScreenWithoutBar = true;
          allowPasswordWithFprintd = false;
          animationDisabled = false;
          animationSpeed = 1;
          autoStartAuth = false;
          avatarImage = "/home/tim/.face";
          boxRadiusRatio = 1;
          clockFormat = "hh\\nmm";
          clockStyle = "custom";
          compactLockScreen = false;
          dimmerOpacity = 0.2;
          enableBlurBehind = true;
          enableLockScreenCountdown = true;
          enableLockScreenMediaControls = false;
          enableShadows = true;
          forceBlackScreenCorners = false;
          iRadiusRatio = 1;
          keybinds = {
            keyDown = ["Down"];
            keyEnter = ["Return" "Enter"];
            keyEscape = ["Esc"];
            keyLeft = ["Left"];
            keyRemove = ["Del"];
            keyRight = ["Right"];
            keyUp = ["Up"];
          };
          language = "";
          lockOnSuspend = true;
          lockScreenAnimations = true;
          lockScreenBlur = 0;
          lockScreenCountdownDuration = 10000;
          lockScreenMonitors = [];
          lockScreenTint = 0;
          passwordChars = false;
          radiusRatio = 1;
          reverseScroll = false;
          scaleRatio = 1;
          screenRadiusRatio = 1;
          shadowDirection = "center";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          showChangelogOnStartup = true;
          showHibernateOnLockScreen = true;
          showScreenCorners = false;
          showSessionButtonsOnLockScreen = true;
          telemetryEnabled = false;
        };
        hooks = {
          colorGeneration = "";
          darkModeChange = "";
          enabled = true;
          performanceModeDisabled = "";
          performanceModeEnabled = "";
          screenLock = "";
          screenUnlock = "";
          # session = "${lib.getExe pkgs.hyprshutdown} -p $1";
          session = "hyprctl dispatch exit && $1"; # TODO: nixify
          startup = "";
          wallpaperChange = "";
        };
        idle = {
          customCommands = "[]";
          enabled = true;
          fadeDuration = 5;
          lockCommand = "";
          lockTimeout = 660;
          resumeLockCommand = "";
          resumeScreenOffCommand = "";
          resumeSuspendCommand = "";
          screenOffCommand = "";
          screenOffTimeout = 600;
          suspendCommand = "";
          suspendTimeout = 1800;
        };
        location = {
          analogClockInCalendar = false;
          firstDayOfWeek = 1;
          hideWeatherCityName = false;
          hideWeatherTimezone = false;
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
          airplaneModeEnabled = false;
          bluetoothAutoConnect = true;
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          bluetoothRssiPollIntervalMs = 10000;
          bluetoothRssiPollingEnabled = false;
          disableDiscoverability = false;
          networkPanelView = "wifi";
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
        noctaliaPerformance = {
          disableDesktopWidgets = true;
          disableWallpaper = true;
        };
        notifications = {
          backgroundOpacity = 1.0;
          clearDismissed = true;
          criticalUrgencyDuration = 15;
          density = "default";
          enableBatteryToast = true;
          enableKeyboardLayoutToast = true;
          enableMarkdown = false;
          enableMediaToast = false;
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
          enabledTypes = [0 1 2 4 3];
          location = "top";
          monitors = [];
          overlayLayer = true;
        };
        plugins = {
          autoUpdate = false;
          notifyUpdates = true;
        };
        sessionMenu = {
          countdownDuration = 2000;
          enableCountdown = true;
          largeButtonsLayout = "grid";
          largeButtonsStyle = false;
          position = "top_right";
          powerOptions = [
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "1";
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "2";
            }
            {
              action = "lock";
              command = "";
              countdownEnabled = false;
              enabled = true;
              keybind = "3";
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "4";
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "5";
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "6";
            }
            {
              action = "rebootToUefi";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "7";
            }
          ];
          showHeader = true;
          showKeybinds = true;
        };
        settingsVersion = 59;
        systemMonitor = {
          batteryCriticalThreshold = 5;
          batteryWarningThreshold = 20;
          cpuCriticalThreshold = 90;
          cpuWarningThreshold = 80;
          criticalColor = "";
          diskAvailCriticalThreshold = 10;
          diskAvailWarningThreshold = 20;
          diskCriticalThreshold = 90;
          diskWarningThreshold = 80;
          enableDgpuMonitoring = false;
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
          gpuCriticalThreshold = 90;
          gpuWarningThreshold = 80;
          memCriticalThreshold = 90;
          memWarningThreshold = 80;
          swapCriticalThreshold = 90;
          swapWarningThreshold = 80;
          tempCriticalThreshold = 90;
          tempWarningThreshold = 80;
          useCustomColors = false;
          warningColor = "";
        };
        templates = {
          activeTemplates = [];
          enableUserTheming = false;
        };
        ui = {
          boxBorderEnabled = false;
          fontDefault = "Geist"; # TODO: nixify
          fontDefaultScale = 1;
          fontFixed = "Maple Mono NF"; # TODO: nixify
          fontFixedScale = 1;
          panelBackgroundOpacity = 1.0;
          panelsAttachedToBar = true;
          scrollbarAlwaysVisible = true;
          settingsPanelMode = "attached";
          settingsPanelSideBarCardStyle = false;
          tooltipsEnabled = true;
          translucentWidgets = false;
        };
        wallpaper = {
          automationEnabled = false;
          directory = "/home/tim/.config/wallpaper"; # TODO: nixify
          enableMultiMonitorDirectories = false;
          enabled = true;
          favorites = [];
          fillColor = "#000000";
          fillMode = "crop";
          hideWallpaperFilenames = false;
          monitorDirectories = [];
          overviewBlur = 0.4;
          overviewEnabled = false;
          overviewTint = 0.6;
          panelPosition = "follow_bar";
          randomIntervalSec = 300;
          setWallpaperOnAllMonitors = true;
          showHiddenFiles = false;
          skipStartupTransition = false;
          solidColor = "#1a1a2e";
          sortOrder = "name";
          transitionDuration = 1500;
          transitionEdgeSmoothness = 0.05;
          transitionType = ["random"];
          useSolidColor = false;
          useWallhaven = false;
          viewMode = "recursive";
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
  };
}

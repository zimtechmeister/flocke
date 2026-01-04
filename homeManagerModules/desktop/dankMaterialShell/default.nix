{
  lib,
  config,
  # inputs,
  ...
}: {
  imports = [
    # inputs.dankMaterialShell.homeModules.dank-material-shell
  ];
  options.my.dankMaterialShell.enable = lib.mkEnableOption "enables dankMaterialShell";
  config = lib.mkIf config.my.dankMaterialShell.enable {
    # programs.dank-material-shell = {
    #   enable = true;
    #   systemd = {
    #     enable = true;
    #     restartIfChanged = true;
    #   };
    #   enableAudioWavelength = true;
    #   enableCalendarEvents = true;
    #   enableDynamicTheming = true;
    #   enableSystemMonitoring = true;
    #   enableVPN = true;
    # };
    home.file.".local/state/DankMaterialShell/session.json".text = builtins.toJSON {
      isLightMode = false;
      # wallpaperPath = "/home/tim/.config/wallpaper/maelifell-iceland.jpeg"; # TODO: this bad
      perMonitorWallpaper = false;
      monitorWallpapers = {};
      perModeWallpaper = false;
      wallpaperPathLight = "";
      wallpaperPathDark = "";
      monitorWallpapersLight = {};
      monitorWallpapersDark = {};
      brightnessExponentialDevices = {};
      brightnessUserSetValues = {};
      brightnessExponentValues = {};
      doNotDisturb = false;
      nightModeEnabled = true;
      nightModeTemperature = 4500;
      nightModeHighTemperature = 6500;
      nightModeAutoEnabled = true;
      nightModeAutoMode = "location";
      nightModeStartHour = 18;
      nightModeStartMinute = 0;
      nightModeEndHour = 6;
      nightModeEndMinute = 0;
      latitude = 0;
      longitude = 0;
      nightModeUseIPLocation = true;
      nightModeLocationProvider = "";
      pinnedApps = [];
      hiddenTrayIds = [];
      selectedGpuIndex = 0;
      nvidiaGpuTempEnabled = false;
      nonNvidiaGpuTempEnabled = false;
      enabledGpuPciIds = [];
      wifiDeviceOverride = "";
      weatherHourlyDetailed = false;
      wallpaperCyclingEnabled = true;
      wallpaperCyclingMode = "interval";
      wallpaperCyclingInterval = 300;
      wallpaperCyclingTime = "06:00";
      monitorCyclingSettings = {};
      lastBrightnessDevice = "";
      launchPrefix = "";
      wallpaperTransition = "fade";
      includedTransitions = [
        "fade"
        "wipe"
        "disc"
        "stripes"
        "iris bloom"
        "pixelate"
        "portal"
      ];
      recentColors = [];
      showThirdPartyPlugins = false;
      configVersion = 1;
    };
    xdg.configFile."DankMaterialShell/settings.json".text = builtins.toJSON {
      currentThemeName = "custom";
      currentThemeCategory = "custom";
      customThemeFile = "${./theme.json}";
      registryThemeVariants = {};
      matugenScheme = "scheme-content";
      runUserMatugenTemplates = false;
      matugenTargetMonitor = "";
      popupTransparency = 1;
      dockTransparency = 1;
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      cornerRadius = 12;
      niriLayoutGapsOverride = -1;
      niriLayoutRadiusOverride = -1;
      use24HourClock = true;
      showSeconds = false;
      useFahrenheit = false;
      nightModeEnabled = false;
      animationSpeed = 1;
      customAnimationDuration = 500;
      wallpaperFillMode = "Fill";
      blurredWallpaperLayer = false;
      blurWallpaperOnOverview = false;
      showLauncherButton = true;
      showWorkspaceSwitcher = true;
      showFocusedWindow = true;
      showWeather = true;
      showMusic = true;
      showClipboard = true;
      showCpuUsage = true;
      showMemUsage = true;
      showCpuTemp = true;
      showGpuTemp = true;
      selectedGpuIndex = 0;
      enabledGpuPciIds = [];
      showSystemTray = true;
      showClock = true;
      showNotificationButton = true;
      showBattery = true;
      showControlCenterButton = true;
      showCapsLockIndicator = true;
      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;
      controlCenterShowAudioPercent = false;
      controlCenterShowVpnIcon = true;
      controlCenterShowBrightnessIcon = false;
      controlCenterShowBrightnessPercent = false;
      controlCenterShowMicIcon = false;
      controlCenterShowMicPercent = true;
      controlCenterShowBatteryIcon = false;
      controlCenterShowPrinterIcon = false;
      showPrivacyButton = true;
      privacyShowMicIcon = true;
      privacyShowCameraIcon = true;
      privacyShowScreenShareIcon = true;
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "brightnessSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "nightMode";
          enabled = true;
          width = 25;
        }
        {
          id = "darkMode";
          enabled = true;
          width = 25;
        }
        {
          id = "idleInhibitor";
          enabled = true;
          width = 25;
        }
        {
          id = "colorPicker";
          enabled = true;
          width = 25;
        }
        {
          id = "doNotDisturb";
          enabled = true;
          width = 25;
        }
        {
          id = "battery";
          enabled = true;
          width = 50;
        }
        {
          id = "builtin_vpn";
          enabled = true;
          width = 50;
        }
      ];
      showWorkspaceIndex = true;
      showWorkspaceName = false;
      showWorkspacePadding = false;
      workspaceScrolling = false;
      showWorkspaceApps = false;
      maxWorkspaceIcons = 3;
      groupWorkspaceApps = true;
      workspacesPerMonitor = false;
      showOccupiedWorkspacesOnly = false;
      reverseScrolling = false;
      dwlShowAllTags = false;
      workspaceNameIcons = {};
      waveProgressEnabled = true;
      scrollTitleEnabled = true;
      audioVisualizerEnabled = true;
      audioScrollMode = "volume";
      clockCompactMode = false;
      focusedWindowCompactMode = false;
      runningAppsCompactMode = true;
      keyboardLayoutNameCompactMode = false;
      runningAppsCurrentWorkspace = false;
      runningAppsGroupByApp = false;
      centeringMode = "index";
      clockDateFormat = "";
      lockDateFormat = "";
      mediaSize = 1;
      appLauncherViewMode = "list";
      spotlightModalViewMode = "list";
      sortAppsAlphabetically = false;
      appLauncherGridColumns = 4;
      spotlightCloseNiriOverview = true;
      niriOverviewOverlayEnabled = true;
      useAutoLocation = false;
      weatherEnabled = true;
      networkPreference = "auto";
      vpnLastConnected = "";
      iconTheme = "System Default";
      launcherLogoMode = "os";
      launcherLogoCustomPath = "";
      launcherLogoColorOverride = "";
      launcherLogoColorInvertOnMode = false;
      launcherLogoBrightness = 0.5;
      launcherLogoContrast = 1;
      launcherLogoSizeOffset = 0;
      fontFamily = "Inter Variable";
      monoFontFamily = "Fira Code";
      fontWeight = 400;
      fontScale = 1;
      notepadUseMonospace = true;
      notepadFontFamily = "";
      notepadFontSize = 14;
      notepadShowLineNumbers = false;
      notepadTransparencyOverride = -1;
      notepadLastCustomTransparency = 0.7;
      soundsEnabled = true;
      useSystemSoundTheme = false;
      soundNewNotification = true;
      soundVolumeChanged = true;
      soundPluggedIn = true;
      acMonitorTimeout = 0;
      acLockTimeout = 0;
      acSuspendTimeout = 0;
      acSuspendBehavior = 0;
      acProfileName = "";
      batteryMonitorTimeout = 0;
      batteryLockTimeout = 0;
      batterySuspendTimeout = 0;
      batterySuspendBehavior = 0;
      batteryProfileName = "";
      batteryChargeLimit = 100;
      lockBeforeSuspend = true;
      loginctlLockIntegration = true;
      fadeToLockEnabled = false;
      fadeToLockGracePeriod = 5;
      launchPrefix = "uwsm-app";
      brightnessDevicePins = {};
      wifiNetworkPins = {};
      bluetoothDevicePins = {};
      audioInputDevicePins = {};
      audioOutputDevicePins = {};
      gtkThemingEnabled = false;
      qtThemingEnabled = false;
      syncModeWithPortal = false;
      terminalsAlwaysDark = false;
      runDmsMatugenTemplates = false;
      matugenTemplateGtk = true;
      matugenTemplateNiri = true;
      matugenTemplateQt5ct = true;
      matugenTemplateQt6ct = true;
      matugenTemplateFirefox = true;
      matugenTemplatePywalfox = true;
      matugenTemplateZenBrowser = true;
      matugenTemplateVesktop = true;
      matugenTemplateEquibop = true;
      matugenTemplateGhostty = true;
      matugenTemplateKitty = true;
      matugenTemplateFoot = true;
      matugenTemplateAlacritty = true;
      matugenTemplateNeovim = true;
      matugenTemplateWezterm = true;
      matugenTemplateDgop = true;
      matugenTemplateKcolorscheme = true;
      matugenTemplateVscode = true;
      showDock = false;
      dockAutoHide = false;
      dockGroupByApp = false;
      dockOpenOnOverview = false;
      dockPosition = 1;
      dockSpacing = 4;
      dockBottomGap = 0;
      dockMargin = 0;
      dockIconSize = 40;
      dockIndicatorStyle = "circle";
      dockBorderEnabled = false;
      dockBorderColor = "surfaceText";
      dockBorderOpacity = 1;
      dockBorderThickness = 1;
      dockIsolateDisplays = false;
      notificationOverlayEnabled = false;
      modalDarkenBackground = true;
      lockScreenShowPowerActions = true;
      lockScreenShowSystemIcons = true;
      lockScreenShowTime = true;
      lockScreenShowDate = true;
      lockScreenShowProfileImage = true;
      lockScreenShowPasswordField = true;
      enableFprint = false;
      maxFprintTries = 15;
      lockScreenActiveMonitor = "all";
      lockScreenInactiveColor = "#000000";
      hideBrightnessSlider = false;
      notificationTimeoutLow = 5000;
      notificationTimeoutNormal = 5000;
      notificationTimeoutCritical = 0;
      notificationPopupPosition = 0;
      osdAlwaysShowValue = true;
      osdPosition = 5;
      osdVolumeEnabled = true;
      osdMediaVolumeEnabled = true;
      osdBrightnessEnabled = true;
      osdIdleInhibitorEnabled = true;
      osdMicMuteEnabled = true;
      osdCapsLockEnabled = true;
      osdPowerProfileEnabled = true;
      osdAudioOutputEnabled = true;
      powerActionConfirm = true;
      powerActionHoldDuration = 0.5;
      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
        "suspend"
        "restart"
      ];
      powerMenuDefaultAction = "poweroff";
      powerMenuGridLayout = false;
      customPowerActionLock = "";
      customPowerActionLogout = "";
      customPowerActionSuspend = "";
      customPowerActionHibernate = "";
      customPowerActionReboot = "";
      customPowerActionPowerOff = "";
      updaterHideWidget = false;
      updaterUseCustomCommand = false;
      updaterCustomCommand = "";
      updaterTerminalAdditionalParams = "";
      displayNameMode = "system";
      screenPreferences = {
        wallpaper = [
          "all"
        ];
      };
      showOnLastDisplay = {};
      niriOutputSettings = {};
      hyprlandOutputSettings = {};
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = true;
          leftWidgets = [
            {
              id = "launcherButton";
              enabled = true;
            }
            {
              id = "workspaceSwitcher";
              enabled = true;
            }
          ];
          centerWidgets = [
            {
              id = "music";
              enabled = true;
              mediaSize = 0;
            }
            {
              id = "clock";
              enabled = true;
              clockCompactMode = false;
            }
            "weather"
          ];
          rightWidgets = [
            {
              id = "systemTray";
              enabled = true;
            }
            {
              id = "clipboard";
              enabled = true;
            }
            {
              id = "cpuUsage";
              enabled = true;
            }
            {
              id = "memUsage";
              enabled = true;
              showSwap = false;
            }
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "battery";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
              showNetworkIcon = true;
              showBluetoothIcon = true;
              showAudioIcon = true;
              showAudioPercent = true;
              showVpnIcon = true;
              showBrightnessIcon = false;
              showBrightnessPercent = false;
              showMicIcon = false;
              showMicPercent = true;
              showBatteryIcon = false;
              showPrinterIcon = false;
            }
          ];
          spacing = 4;
          innerPadding = 4;
          bottomGap = 0;
          transparency = 1;
          widgetTransparency = 1;
          squareCorners = false;
          noBackground = false;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;
          fontScale = 1;
          autoHide = false;
          autoHideDelay = 250;
          showOnWindowsOpen = false;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          maximizeDetection = false;
          scrollEnabled = true;
          scrollXBehavior = "column";
          scrollYBehavior = "workspace";
        }
      ];
      desktopClockEnabled = false;
      desktopClockStyle = "analog";
      desktopClockTransparency = 0.8;
      desktopClockColorMode = "primary";
      desktopClockCustomColor = {
        r = 1;
        g = 1;
        b = 1;
        a = 1;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        hslHue = -1;
        hslSaturation = 0;
        hslLightness = 1;
        valid = true;
      };
      desktopClockShowDate = true;
      desktopClockShowAnalogNumbers = false;
      desktopClockShowAnalogSeconds = true;
      desktopClockX = -1;
      desktopClockY = -1;
      desktopClockWidth = 280;
      desktopClockHeight = 180;
      desktopClockDisplayPreferences = [
        "all"
      ];
      systemMonitorEnabled = false;
      systemMonitorShowHeader = true;
      systemMonitorTransparency = 0.8;
      systemMonitorColorMode = "primary";
      systemMonitorCustomColor = {
        r = 1;
        g = 1;
        b = 1;
        a = 1;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        hslHue = -1;
        hslSaturation = 0;
        hslLightness = 1;
        valid = true;
      };
      systemMonitorShowCpu = true;
      systemMonitorShowCpuGraph = true;
      systemMonitorShowCpuTemp = true;
      systemMonitorShowGpuTemp = false;
      systemMonitorGpuPciId = "";
      systemMonitorShowMemory = true;
      systemMonitorShowMemoryGraph = true;
      systemMonitorShowNetwork = true;
      systemMonitorShowNetworkGraph = true;
      systemMonitorShowDisk = true;
      systemMonitorShowTopProcesses = false;
      systemMonitorTopProcessCount = 3;
      systemMonitorTopProcessSortBy = "cpu";
      systemMonitorGraphInterval = 60;
      systemMonitorLayoutMode = "auto";
      systemMonitorX = -1;
      systemMonitorY = -1;
      systemMonitorWidth = 320;
      systemMonitorHeight = 480;
      systemMonitorDisplayPreferences = [
        "all"
      ];
      systemMonitorVariants = [];
      desktopWidgetPositions = {};
      desktopWidgetGridSettings = {};
      desktopWidgetInstances = [];
      configVersion = 5;
    };
  };
}

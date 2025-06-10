{
  lib,
  config,
  ...
}: {
  options.vesktop.enable = lib.mkEnableOption "enable vesktop";
  config = lib.mkIf config.vesktop.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        discordBranch = "stable";
        minimizeToTray = false;
        tray = false;
      };
      vencord.settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        plugins = {
          FakeNitro.enabled = true;
          CallTimer.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          ServerInfo.enabled = true;
          ShowConnections.enabled = true;
          ShowHiddenChannels.enabled = true;
          VoiceChatDoubleClick.enabled = true;
          VolumeBooster.enabled = true;
        };
      };
    };
  };
}

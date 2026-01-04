{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.desktop-packages.enable = lib.mkEnableOption "desktop-packages";
  config = lib.mkIf config.my.desktop-packages.enable {

    # TODO: move
    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        # restartIfChanged = true;
      };
      enableAudioWavelength = true;
      enableCalendarEvents = true;
      enableDynamicTheming = true;
      enableSystemMonitoring = true;
      enableVPN = true;
    };

    services.printing.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    environment.systemPackages = with pkgs; [
      hyprpicker
      wl-kbptr
      nwg-displays

      grim
      slurp
      satty

      wl-clipboard
      cliphist
      wev
      waybar
      swaynotificationcenter
      smartmontools
      pulsemixer

      # some progams
      pavucontrol
      easyeffects

      glib # what do i need this fore? i thik this is some dependency

      chromium

      discord
      thunderbird

      nautilus
      zathura
      mpv
      imv
      qimgv

      # usefulltools
      switcheroo

      zoom-us

      # not necesary?
      typst
      pandoc
      imagemagick
      miktex # \
      texliveFull #  > might only need one?
      python312Packages.pylatexenc # /

      via
      kdePackages.kdenlive
      gimp
    ];
    services.udev.packages = [pkgs.via];
    hardware.opentabletdriver.enable = true; # TODO: not working as expected
  };
}

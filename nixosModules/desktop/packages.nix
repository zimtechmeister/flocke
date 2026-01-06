{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.desktop-packages.enable = lib.mkEnableOption "desktop-packages";
  config = lib.mkIf config.my.desktop-packages.enable {
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
      pandoc
      imagemagick



      # not necesary?
      zoom-us

      typst
      zotero

      via
      kdePackages.kdenlive
      gimp
    ];
    services.udev.packages = [pkgs.via];
    hardware.opentabletdriver.enable = true; # TODO: not working as expected
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop-packages.enable =
      lib.mkEnableOption "desktop-packages";
  };
  config = lib.mkIf config.desktop-packages.enable {
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

      ghostty

      firefox
      chromium

      discord
      thunderbird

      nautilus
      zathura
      mpv
      imv
      qimgv

      zoom-us

      # not necesary?
      via
      libsForQt5.kdenlive
      gimp
    ];
    services.udev.packages = [pkgs.via];
    hardware.opentabletdriver.enable = true; # TODO: not working as expected
  };
}

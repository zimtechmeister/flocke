{
  pkgs,
  lib,
  config,
  self,
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
      wl-clipboard
      cliphist
      wev
      smartmontools
      pulsemixer

      chromium
      self.packages.${pkgs.stdenv.hostPlatform.system}.helium

      discord
      thunderbird

      pavucontrol
      easyeffects

      nautilus
      zathura
      mpv
      imv
      qimgv

      zotero

      # usefulltools
      switcheroo
      pandoc
      imagemagick

    ];
    services.udev.packages = [pkgs.via];
    hardware.opentabletdriver.enable = true; # TODO: not working as expected
  };
}

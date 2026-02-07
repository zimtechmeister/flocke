{
  lib,
  config,
  ...
}: {
  options.my.kanata.enable = lib.mkEnableOption "enables kanata";

  config = lib.mkIf config.my.kanata.enable {
    hardware.uinput.enable = true;
    services.kanata = {
      enable = true;
      keyboards = {
        internal = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )

            (defalias
              ;; Caps Lock: Tap for Esc, Hold for Arrows Layer
              ;; tap-hold-press ensures that if you press another key while holding caps,
              ;; it immediately triggers the layer, making it snappier.
              caps (tap-hold-press 200 200 esc (layer-toggle arrows))
            )

            (deflayer base
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              @caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )

            (deflayer arrows
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    left down up   right _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _              _              _    _    _
            )
          '';
        };
      };
    };
  };
}

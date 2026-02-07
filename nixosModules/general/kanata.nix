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
          # "Timeless Home Row Mods" for kanata
          # https://www.reddit.com/r/ErgoMechKeyboards/comments/1qosvc0/a_try_on_urobs_timeless_home_row_mods_for_kanata/
          config = ''
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )

            (defvar
              ;; Keys that trigger left-hand mods (Right side + Space)
              r-triggers (
                6 7 8 9 0 - = bspc
                y u i o p [ ] \
                h j k l ; ' ret
                n m , . / rsft
                ralt rmet rctl
                spc
              )
              ;; Keys that trigger right-hand mods (Left side + Space)
              l-triggers (
                grv 1 2 3 4 5
                tab q w e r t
                caps a s d f g
                lsft z x c v b
                lctl lmet lalt
                spc
              )
            )

            (defalias
              lt (tap-hold-release 300 175 esc (layer-toggle nav))

              ;; Homerow Mods
              ;; Left Hand
              a (tap-hold-release-keys 300 175 a lalt $r-triggers)
              s (tap-hold-release-keys 300 175 s lctl $r-triggers)
              d (tap-hold-release-keys 300 175 d lsft $r-triggers)
              f (tap-hold-release-keys 300 175 f lmet $r-triggers)
              g (tap-hold-release-keys 300 175 g ralt $r-triggers)

              ;; Right Hand
              h (tap-hold-release-keys 300 175 h ralt $l-triggers)
              j (tap-hold-release-keys 300 175 j lmet $l-triggers)
              k (tap-hold-release-keys 300 175 k lsft $l-triggers)
              l (tap-hold-release-keys 300 175 l lctl $l-triggers)
              ; (tap-hold-release-keys 300 175 ; lalt $l-triggers)
            )

            (deflayer base
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              @lt  a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt @lt  rctl
            )
            (deflayer nav
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    7    8    9    0    _    _    _    _    _    _    _    _
              _    _    4    5    6    _    left down up   right _    _    _
              _    _    1    2    3    _    _    _    _    _    _    _
              _    _    _              _              _    _    _
            )
          '';
        };
      };
    };
  };
}

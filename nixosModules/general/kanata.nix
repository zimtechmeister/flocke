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
          # there is a hack to make require-prior-idle work but i dont like cheating and dont care too much
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
              ;; Timing Variables
              tapping-term 300
              quick-tap 175

              ;; left-hand keys no homerow mods
              l-keys (
                grv 1 2 3 4 5
                tab q w e r t
                caps
                lsft z x c v b
                lctl lmet lalt
              )
              ;; left-hand homerow mods
              l-hrm (
                a s d f g
              )
              ;; right-hand keys no homerow mods
              r-keys (
                6 7 8 9 0 - = bspc
                y u i o p [ ] \
                ' ret
                n m , . / rsft
                ralt rmet rctl
              )
              ;; right-hand homerow mods
              r-hrm (
                h j k l ;
              )
            )

            (defalias
              lt (tap-hold-release 300 175 esc (layer-toggle nav))

              ;; Homerow Mods
              ;; Left Hand
              a (tap-hold-release-tap-keys-release $quick-tap $tapping-term a lalt $l-keys $l-hrm)
              s (tap-hold-release-tap-keys-release $quick-tap $tapping-term s lctl $l-keys $l-hrm)
              d (tap-hold-release-tap-keys-release $quick-tap $tapping-term d lsft $l-keys $l-hrm)
              f (tap-hold-release-tap-keys-release $quick-tap $tapping-term f lmet $l-keys $l-hrm)
              g (tap-hold-release-tap-keys-release $quick-tap $tapping-term g ralt $l-keys $l-hrm)

              ;; Right Hand
              h (tap-hold-release-tap-keys-release $quick-tap $tapping-term h ralt $r-keys $r-hrm)
              j (tap-hold-release-tap-keys-release $quick-tap $tapping-term j rmet $r-keys $r-hrm)
              k (tap-hold-release-tap-keys-release $quick-tap $tapping-term k rsft $r-keys $r-hrm)
              l (tap-hold-release-tap-keys-release $quick-tap $tapping-term l rctl $r-keys $r-hrm)
              ; (tap-hold-release-tap-keys-release $quick-tap $tapping-term ; ralt $r-keys $r-hrm)
            )

            (deflayer base
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              @lt  @a   @s   @d   @f   @g   @h   @j   @k   @l   @;   '    ret
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

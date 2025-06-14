{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    maple-mono.NF
    monocraft
    nerd-fonts.terminess-ttf
    nerd-fonts.fira-code
    nerd-fonts.geist-mono
    nerd-fonts.jetbrains-mono

    geist-font

    twemoji-color-font

    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    google-fonts
  ];
}

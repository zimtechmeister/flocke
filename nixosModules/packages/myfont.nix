{pkgs, ...}: {
  fonts.packages = with pkgs; [
    # fira-code
    nerd-fonts.fira-code
    nerd-fonts.geist-mono
    nerd-fonts.symbols-only
    monocraft # is this with nerd-fonts
    maple-mono.NF
    geist-font
    twemoji-color-font
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    google-fonts # How many fonts is this? maybe too many
  ];
}

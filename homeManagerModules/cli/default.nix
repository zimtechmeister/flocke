{lib, ...} : {
  imports = [
    ./zsh
  ];
  zsh.enable =
    lib.mkDefault true;
}

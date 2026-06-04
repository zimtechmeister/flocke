let
  desktopTim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLOQ37NzU1kJ7ZIgl1t03/z7uiQ0kQ969hQ7U5nY9bY";
  t480Tim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM9wmhtXaBDDL88/DW/yzjX2Hf37kRwWgpTFjxlg+cgL";
  users = [desktopTim t480Tim];

  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIJx2z0TNBruTlznSkizww/1uRldGhyFb1VcEKzaIdM9";
  t480 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9nGjgEoq06X+d42BbxeCdY4gXPvtPKFT70Ph8V6xSX";
  systems = [desktop t480];
in {
  "root-password.age".publicKeys = users ++ systems;
  "tim-password.age".publicKeys = users ++ systems;
  "disk-encryption.age".publicKeys = users ++ systems;
}

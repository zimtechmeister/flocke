let
  desktopTim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLOQ37NzU1kJ7ZIgl1t03/z7uiQ0kQ969hQ7U5nY9bY";
  users = [ desktopTim ];

  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIJx2z0TNBruTlznSkizww/1uRldGhyFb1VcEKzaIdM9";
  systems = [ desktop ];
in
{
  "root-password.age".publicKeys = users ++ systems;
  "tim-password.age".publicKeys = users ++ systems;
}

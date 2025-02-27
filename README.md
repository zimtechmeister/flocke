# usefull nix commands
rebuild nixos with flake
```bash
sudo nixos-rebuild switch --flake /home/tim/nixos#nixBTW
```
update flake
```bash
nix flake update
```

clean with nh installed
```bash
nh clean all -- keep 2 --dry
```



list all generations (new one after each nixos-rebuild
```bash
sudo nix-env --list-generations -p /nix/var/nix/profiles/system
```
delete all generations except the current one
```bash
nix-collect-garbage -d
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
```

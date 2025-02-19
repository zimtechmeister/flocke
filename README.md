# usefull nix commands
rebuild nixos with flake
```bash
sudo nixos-rebuild switch --flake .#default
```
update flake
```bash
nix flake update
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

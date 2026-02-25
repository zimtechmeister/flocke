Personal flake for deskop pc laptop and home-server(optiplex3000)
<details>
<summary>Installation (NixOS)</summary>

requires NixOS [ISO](https://nixos.org/download/#nixos-iso)  
write the image to the USB flash drive.
```bash
sudo dd bs=4M conv=fsync oflag=direct status=progress if=<path-to-image> of=/dev/sdX
```
generate hardwareconfig if needed:
```bash
nixos-generate-config --no-filesystems --force --dir ./ # when to use --root?
```
there is a disko-install command which should format the disk and install nixos, but ram usage is very high and it seems to be better to do it manually
```bash
sudo nix run --extra-experimental-features 'nix-command flakes' github:nix-community/disko/latest#disko-install -- --flake .#desktop --disk main /dev/sda
```
partition from live-iso:  
clone the repo first
```bash
sudo nix \
--extra-experimental-features 'nix-command flakes' \
run github:nix-community/disko/latest -- --mode disko ./hosts/desktop/disko.nix
```
Installation (dont forget to enter the root password in this step)
```bash
sudo nixos-install --flake .#desktop
```
set user password with `passwd tim`

launch `display settings`/ `nwg-displays` and apply the correct display configuration
</details>

<details>
<summary>Commands</summary>

Rebuild: "desktop" is the host in those examples
```bash
sudo nixos-rebuild switch --flake github:zimtechmeister/flocke#desktop
```
```bash
nh os switch /path/to/flake -H desktop
```
Update flake
```bash
nix flake update
```

Update packages locked to a specific version (helium)
```bash
cd /path/to/flake
nix run nixpkgs#nix-update -- --flake helium
```

run my Neovim distribution
```bash
nix run github:zimtechmeister/flocke#neovix
```

</details>

<details>
<summary>GarbageCollect</summary>

```bash
sudo nix-collect-garbage -d
```

```bash
sudo nix-store --optimise
```

</details>

<details>
<summary>todo</summary>

[generally good source](https://www.vimjoyer.com/nix)
[vimjoyer](https://github.com/Goxore/nixconf)
- [ ] update (e.g. helium) using github actions
- [ ] devenv / devbox / flox / direnv / my own
- [ ] secrets sops [vimjoyer](https://www.youtube.com/watch?v=G5f6GC7SnhU)
- [ ] [hardware](https://github.com/NixOS/nixos-hardware) / [facter](https://github.com/nix-community/nixos-facter)
- [ ] secureboot [lancaboote](https://github.com/nix-community/lanzaboote)
- [ ] [anywhere](https://github.com/nix-community/nixos-anywhere) [example](https://github.com/nix-community/nixos-anywhere-examples)
## laptop only:
- [ ] tlp

</details>

<details>
<summary>eduroam</summary>

download the eduroam script from [here](https://cat.eduroam.org/)  
enter a shell with
```bash
nix-shell -p "python3.withPackages (ps: with ps; [ dbus-python ])"
```
and execute the eduroamscript
```bash
python ./location/eduroamscript
```
</details>

# Installation (NixOS)
requires NixOS [ISO](https://nixos.org/download/#nixos-iso)  
write the image to the USB flash drive.
```bash
sudo dd bs=4M conv=fsync oflag=direct status=progress if=<path-to-image> of=/dev/sdX
```
generate hardwareconfig:
```bash
nixos-generate-config --no-filesystems --force --dir ./
```
install from live-iso:
```bash
sudo nix run --extra-experimental-features 'nix-command flakes' github:nix-community/disko/latest#disko-install -- --flake github:zimtechmeister/flocke#desktop &
sudo nixos-install --extra-experimental-features 'nix-command flakes' --flake github:zimtechmeister/flocke#desktop
```
Rebuild: "desktop" is the host in those examples
```bash
sudo nixos-rebuild switch --flake github:zimtechmeister/flocke#desktop
```
```bash
nh os switch /path/to/flake -H desktop
```

# todo:
- [ ] hardwareconfig checkout cachyOs
- [ ] [impermanence](https://github.com/nix-community/impermanence)
- [ ] devenv
- [ ] scripting in nix [vimjoyer](https://www.youtube.com/watch?v=qRE6kf30u4g)
- [ ] secrets sops [vimjoyer](https://www.youtube.com/watch?v=G5f6GC7SnhU)
- [ ] make a live-iso with [disko](https://github.com/nix-community/disko/blob/master/docs/disko-images.md)
## laptop only:
- [ ] tlp

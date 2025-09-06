# Installation (NixOS)
requires NixOS [ISO](https://nixos.org/download/#nixos-iso)  
write the image to the USB flash drive.
```bash
sudo dd bs=4M conv=fsync oflag=direct status=progress if=<path-to-image> of=/dev/sdX
```
generate hardwareconfig:
```bash
nixos-generate-config --no-filesystems --force --dir ./ # when to use --root?
```
<!-- there is a disko-install command which should do both in one step but im not shure if it works correctly -->
<!-- sudo nix run --extra-experimental-features 'nix-command flakes' github:nix-community/disko/latest#disko-install -- --flake .#desktop --disk main /dev/sda -->
install from live-iso:
clone the repo first
```bash
sudo nix \
extra-experimental-features 'nix-command flakes' \
run github:nix-community/disko/latest -- --mode destroy,format,mount ./hosts/t480/disko.nix
# run github:nix-community/disko/latest -- --mode disko ./hosts/t480/disko.nix
```
then
```bash
sudo nixos-install --flake .#desktop
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

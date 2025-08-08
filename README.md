# Installation (NixOS)
requires NixOS [ISO](https://nixos.org/download/#nixos-iso)  
write the image to the USB flash drive.
```bash
sudo dd bs=4M conv=fsync oflag=direct status=progress if=<path-to-image> of=/dev/sdX
```
generate hardwareconfig:
```bash
sudo nixos-generate-config --dir /some/dir --force
```
Rebuild: "desktop" is the host in those examples
```bash
sudo nixos-rebuild switch --flake github:zimtechmeister/flocke#desktop
```
```bash
nh os switch /path/to/flake -H desktop
```

# todo:
- [ ] understand the difference between builtins.fetchurl and pkgs.fetchurl
- [ ] anyrun cant scroll
- [ ] try walker again
- [ ] hardwareconfig checkout cachyOs
- [ ] disco
- [ ] [impermanence](https://github.com/nix-community/impermanence)
- [ ] devenv
- [ ] scripting in nix [vimjoyer](https://www.youtube.com/watch?v=qRE6kf30u4g)
- [ ] secrets sops [vimjoyer](https://www.youtube.com/watch?v=G5f6GC7SnhU)
## laptop only:
- [ ] tlp

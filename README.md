# Installation (NixOS)
requires NixOS [ISO](https://nixos.org/download/#nixos-iso)  
generate hardwareconfig:
```bash
sudo nixos-generate-config --dir /some/dir --force
```
Rebuild: "desktop" is the host in those examples
```bash
sudo nixos-rebuild --extra-experimental-features "nix-command flakes" switch --flake github:zimtechmeister/nixos#desktop
```
```bash
nh os switch /path/to/flake -H desktop -u
```

# todo:
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

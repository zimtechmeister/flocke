# Installation (NixOS)
requires NixOS [ISO](https://nixos.org/download/#nixos-iso)  
generate hardwareconfig:
```bash
sudo nixos-generate-config --dir /some/dir --force
```
Rebuild: "PC" is the host in those examples
```bash
sudo nixos-rebuild --extra-experimental-features "nix-command flakes" switch --flake github:zimtechmeister/nixos#PC
```
```bash
nh os switch /path/to/flake -H PC -u
```

# todo:
- [ ] anyrun cant scroll
- [ ] hardwareconfig
- [ ] disco
- [ ] [impermanence](https://github.com/nix-community/impermanence)
- [ ] devenv
- [ ] scripting in nix [vimjoyer](https://www.youtube.com/watch?v=qRE6kf30u4g)
- [ ] secrets sops [vimjoyer](https://www.youtube.com/watch?v=G5f6GC7SnhU)
- [ ] how do you want to manage wallpaper [raf's solution](https://github.com/NotAShelf/wallpkgs)
## laptop only:
- [ ] tlp

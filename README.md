Rebuild "PC" is the host in those examples
```bash
sudo nixos-rebuild --extra-experimental-features "nix-command flakes" switch --flake github:zimtechmeister/nixos#PC
nh os switch /path/to/flake -H PC -u
```

# todo:
- [ ] apply systemFont to waybar and rofi
- [ ] stylix
- [ ] hardwareconfig
- [ ] disco
- [ ] how do you want to manage wallpaper
## laptop only:
- [ ] tlp

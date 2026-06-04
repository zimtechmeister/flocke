# Installation
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

# Secure Boot
1. Put Secure Boot into **Setup Mode** (to allow automated enrollment).  
   In UEFI, look for options like "Secure Boot", "Key Management", or
   "Security". Select "Reset to Setup Mode" or similar to clear existing keys
   and allow new ones to be enrolled.

> [!WARNING]
> - If you are using a ThinkPad, do NOT select "Clear All Secure Boot Keys"; use "Reset to Setup Mode" to prevent deleting the Forbidden Signature Database (dbx).  
> - If you are on a Framework 13 (Core Ultra), manually delete keys from the PK/KEK/DB sections as "Erase all Secure Boot settings" is bugged in the firmware.

2. Boot into NixOS and rebuild the configuration. NixOS will automatically generate keys (under `/var/lib/sbctl`) and enroll them:
   ```bash
   sudo nixos-rebuild switch --flake .
   ```
> [!NOTE]
> automatic enrollment may fail on some hardware due to different UEFI implementations.
> If it does, you can try enrolling the keys manually or adjust the host specific limine config
> ```bash
> sudo sbctl enroll-keys --microsoft
> ```
> useful options are:
> ```
> -m --microsoft
> -b --firmware-builtin
> -i --ignore-immutable
> ```
> my t480 for example works with `sudo sbctl enroll-keys -m -i`

3. Reboot, enter your UEFI settings, and enable/enforce **Secure Boot**.

4. Verify Secure Boot status:
   ```bash
   sudo bootctl status
   # or check using sbctl
   sudo sbctl status
   ```

# Commands
## Rebuild
Rebuild: "desktop" is the host in those examples
```bash
sudo nixos-rebuild switch --flake github:zimtechmeister/flocke#desktop
```
```bash
nh os switch /path/to/flake -H desktop
```

## Update
Update flake
```bash
nix flake update
```

Update packages locked to a specific version (helium)
```bash
cd /path/to/flake
nix run nixpkgs#nix-update -- --flake helium
```

## Garbage Collection

```bash
sudo nix-collect-garbage -d
```

```bash
sudo nix-store --optimise
```

# TODO
[generally good source](https://www.vimjoyer.com/nix)
[vimjoyer](https://github.com/Goxore/nixconf)
- [ ] update (e.g. helium) using github actions
- [ ] devenv / devbox / flox / direnv / my own
- [ ] secrets sops [vimjoyer](https://www.youtube.com/watch?v=G5f6GC7SnhU)
- [ ] [hardware](https://github.com/NixOS/nixos-hardware) / [facter](https://github.com/nix-community/nixos-facter)
- [ ] [anywhere](https://github.com/nix-community/nixos-anywhere) [example](https://github.com/nix-community/nixos-anywhere-examples)
laptop only:
- [ ] tlp

# Eduroam
download the eduroam script from [here](https://cat.eduroam.org/)  
enter a shell with
```bash
nix-shell -p "python3.withPackages (ps: with ps; [ dbus-python ])"
```
and execute the eduroamscript\
in nmtui edit the eduroam connection and set "Store password for all users" so
you wont need to enter the password every time you log in
```bash
python ./location/eduroamscript
```

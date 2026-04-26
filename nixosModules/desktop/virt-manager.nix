{
  lib,
  config,
  pkgs,
  ...
}: {
  options.my.virt-manager.enable = lib.mkEnableOption "virt-manager";
  config = lib.mkIf config.my.virt-manager.enable {
    programs.virt-manager.enable = true;
    users.users.tim.extraGroups = ["libvirtd"];
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm; # The qemu package to use. pkgs.qemu can emulate alien architectures (e.g. aarch64 on x86) pkgs.qemu_kvm saves disk space allowing to emulate only host architectures.
        swtpm.enable = true; # Software-TPM-emulator
      };
    };
    programs.dconf.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    services.spice-vdagentd.enable = true;
    networking.firewall.checkReversePath = false;
  };
}

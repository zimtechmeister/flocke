{
  disko.devices = {
    disk.main = {
      # NOTE: find the disk id by the most plausable option that points to ../../sda forexample
      # ls /dev/disk/by-id/
      # device = "/dev/disk/by-id/ata-Samsung_SSD_750_EVO_250GB_S33SNWBH664027Y";
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # TODO: remove later
          # If you use pure UEFI, this is probably useless, but it doesn’t hurt.
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"]; # security measurements only root can edit /boot
            };
          };
          swap = {
            size = "8G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}

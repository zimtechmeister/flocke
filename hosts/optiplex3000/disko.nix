{config, ...}: {
  disko.devices = {
    disk.main = {
      device = "ata-Vi550_S3_SSD_4935252083714985";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"]; # security measurements only root can edit /boot
            };
          };
          swap = {
            size = "16G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          bcachefs = {
            size = "100%";
            content = {
              type = "bcachefs";
              filesystem = "pool";
            };
          };
        };
      };
    };
    bcachefs_filesystems = {
      pool = {
        type = "bcachefs_filesystem";
        passwordFile = config.age.secrets.disk-encryption.path;
        extraFormatArgs = [
          "--compression=zstd"
          "--background_compression=zstd"
        ];
        subvolumes = {
          "subvolumes/root" = {
            mountpoint = "/";
            mountOptions = ["noatime"];
          };
          "subvolumes/home" = {
            mountpoint = "/home";
            mountOptions = ["noatime"];
          };
        };
      };
    };
  };
}

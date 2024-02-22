{
  disko.devices.disk.ssd = {
    type = "disk";
    device = "/dev/disk/by-id/nvme-CT1000P3PSSD8_2226E6424FDD";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "500M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        swap = {
          size = "8G";
          content = {
            type = "swap";
            resumeDevice = true; # resume from hiberation from this device
          };
        };
        root = {
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
}

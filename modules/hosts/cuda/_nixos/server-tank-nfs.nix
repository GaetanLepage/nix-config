{
  fileSystems."/mnt/server" = {
    device = "192.168.1.100:/tank";

    fsType = "nfs";

    options = [
      "noauto"
      "x-systemd.automount"
      "nfsvers=4"

      # disconnects after 10 minutes (i.e. 600 seconds)
      "x-systemd.idle-timeout=600"

      "x-systemd.mount-timeout=10"
    ];
  };
}

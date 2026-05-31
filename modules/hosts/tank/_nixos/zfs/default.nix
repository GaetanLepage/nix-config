{
  imports = [
    ./remote-backup.nix
  ];
  boot = {
    # Enable zfs support
    supportedFilesystems = [ "zfs" ];

    # Forcibly import the ZFS root pool(s) during early boot.
    # It is highly recommended to keep this option disabled as it bypasses ZFS safeguard that
    # protect your pools.
    # If NixOS fails to boot because it cannot import the root pool, you should boot with the
    # `zfs_force=1` option as a kernel parameter (e.g. by manually editing the kernel params via
    # your bootloader).
    # You should only need to do this after unclean shutdowns.
    zfs.forceImportRoot = false;
  };

  fileSystems = {
    "/tank" = {
      device = "tank";
      fsType = "zfs";
    };

    "/tank/tmp" = {
      device = "tank/tmp";
      fsType = "zfs";
    };
  };

  services.zfs = {
    autoScrub.enable = true;

    autoSnapshot = {
      enable = true;

      flags = "-k -p --utc";
    };
  };
}

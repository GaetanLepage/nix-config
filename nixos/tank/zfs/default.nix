{
  imports = [
    ./remote-backup.nix
  ];
  # Enable zfs support
  boot.supportedFilesystems = [ "zfs" ];

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

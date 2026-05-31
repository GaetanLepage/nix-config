{ pkgs, ... }:
{
  # Needed for ZFS
  # generated using `head -c 8 /etc/machine-id`
  networking.hostId = "02fa145d";

  # ZFS
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      # Forcibly import the ZFS root pool(s) during early boot.
      # It is highly recommended to keep this option disabled as it bypasses ZFS safeguard that
      # protect your pools.
      # If NixOS fails to boot because it cannot import the root pool, you should boot with the
      # `zfs_force=1` option as a kernel parameter (e.g. by manually editing the kernel params via
      # your bootloader).
      # You should only need to do this after unclean shutdowns.
      forceImportRoot = false;

      extraPools = [ "backup_pool" ];
    };
  };

  ###################
  # ZFS replication #
  ###################
  environment.systemPackages = [ pkgs.lz4 ];

  users.users.zfs = {
    isNormalUser = true;

    # Can be ssh-ed with 'rsa_server'
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAkpHHaqWb9Gjixhl53YuqO25VqBIJX7LaaigSr5NDUE"
    ];
  };
}

{
  flake.modules.nixos.host_backup =
    { pkgs, ... }:
    {
      # Needed for ZFS
      # generated using `head -c 8 /etc/machine-id`
      networking.hostId = "02fa145d";

      # ZFS
      boot = {
        supportedFilesystems = [ "zfs" ];
        zfs.extraPools = [ "backup_pool" ];
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
    };
}

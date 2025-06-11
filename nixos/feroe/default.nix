{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
    ./wireguard
  ];

  networking = {
    hostName = "feroe";

    # Needed for ZFS
    # generated using `head -c 8 /etc/machine-id`
    hostId = "02fa145d";
  };

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBSFYOqETOI1WDbKieqGIz5iHzys9n92eo/KBhPHeJh";

  # ZFS
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.extraPools = [ "backup_pool" ];
  };

  my-modules = {
    cloudBackup.enable = true;
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

  system.stateVersion = "22.05";
}

{
  config,
  ...
}:
{
  age.secrets.zfs-remote-backup-ssh-key.rekeyFile = ./ssh-key.age;

  services.zfs.autoReplication = {
    enable = true;

    localFilesystem = "tank";

    identityFilePath = config.age.secrets.zfs-remote-backup-ssh-key.path;

    host = "10.10.10.4";
    username = "zfs";
    remoteFilesystem = "backup_pool/tank_backup";
  };

  programs.ssh.knownHosts.${config.services.zfs.autoReplication.host}.publicKey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBSFYOqETOI1WDbKieqGIz5iHzys9n92eo/KBhPHeJh";
}

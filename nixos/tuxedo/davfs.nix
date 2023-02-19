{config, ...}: {
  # https://lorenzo.mile.si/automatically-mount-nextcloud-user-homedir-via-davfs-and-autofs/677/
  services.davfs2 = {
    enable = true;

    extraConfig = ''
      # NextCloud does not support locks
      use_locks 0
    '';
  };

  users.users.gaetan.extraGroups = [config.services.davfs2.davGroup];
}

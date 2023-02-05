{ pkgs, config, ... }:
{
    age.secrets.davfs_nextcloud.file = ../../secrets/davfs_nextcloud.age;

    services.autofs = {
        enable = true;

        timeout = 60;


        autoMaster = let
            davfsConf = pkgs.writeText "davfs2.conf" ''
                secrets ${config.age.secrets.davfs_nextcloud.path}
            '';

            mapConf = pkgs.writeText "mnt" ''
              alya      -fstype=nfs4    10.10.10.4:/local_scratch
              server    -fstype=nfs4    10.10.10.1:/tank

              nextcloud -fstype=davfs,uid=1000,file_mode=600,dir_mode=700,conf=${davfsConf},rw :https\://cloud.glepage.com/remote.php/dav/files/glepage
            '';
        in ''
            /mnt file:${mapConf}
        '';
    };
}

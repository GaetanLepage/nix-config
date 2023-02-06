{ pkgs, config, ... }:
{
    age.secrets = {
        davfs_nextcloud.file = ../../secrets/davfs_nextcloud.age;
        rsa_sshfs.file = ../../secrets/ssh/rsa_sshfs.age;
    };

    environment.systemPackages = [ pkgs.sshfs ];

    services.autofs = {
        enable = true;

        autoMaster = let
            davfsConf = pkgs.writeText "davfs2.conf" ''
                secrets ${config.age.secrets.davfs_nextcloud.path}
            '';

            uid = toString config.users.users.gaetan.uid;
            gid = toString config.users.groups.gaetan.gid;

            ###############
            # NFS & DAVFS #
            ###############

            mapConf = pkgs.writeText "autofs.mnt" ''
                alya \
                    -fstype=nfs4 \
                    10.10.10.4:/local_scratch

                server \
                    -fstype=nfs4 \
                    10.10.10.1:/tank

                nextcloud \
                    -fstype=davfs,uid=${uid},file_mode=600,dir_mode=700,conf=${davfsConf},rw \
                    :https\://cloud.glepage.com/remote.php/dav/files/glepage
            '';

            #########
            # SSHFS #
            #########

            pathToRsaKey = config.age.secrets.rsa_sshfs.path;
            sshfsOptions = "-fstype=fuse.sshfs,rw,allow_other,IdentityFile=${pathToRsaKey}";

            gricadProxyCommand = "ssh -i ${pathToRsaKey} -q lepageg-ext@access-gricad.univ-grenoble-alpes.fr nc -w 60 bigfoot 22";

            sshfsMapConf = pkgs.writeText "autofs.mnt.sshfs" ''
                alya \
                    ${sshfsOptions} \
                    :galepage@10.10.10.4\:/local_scratch/galepage

                bigfoot \
                    ${sshfsOptions},ProxyCommand="${gricadProxyCommand}" \
                    :lepageg-ext@bigfoot\:/bettik/lepageg-ext
            '';

        in ''
            /mnt        ${mapConf}          --timeout 60
            /mnt/sshfs  ${sshfsMapConf}     uid=${uid},gid=${gid},--timeout=60,--ghost
        '';
    };
}

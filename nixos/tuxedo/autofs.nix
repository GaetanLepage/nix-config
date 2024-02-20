{
  pkgs,
  config,
  ...
}: {
  age.secrets.rsa_sshfs.file = ../../secrets/ssh/rsa_sshfs.age;

  environment.systemPackages = [pkgs.sshfs];

  services.autofs = {
    enable = true;

    autoMaster = let
      uid = toString config.users.users.gaetan.uid;
      gid = toString config.users.groups.gaetan.gid;

      ###############
      # NFS & DAVFS #
      ###############

      mapConf = pkgs.writeText "autofs.mnt" ''
        alya \
            -fstype=nfs4 \
            10.10.10.4:/galepage

        server \
            -fstype=nfs4 \
            10.10.10.1:/tank
      '';

      #########
      # SSHFS #
      #########

      # NOTE:
      # It is needed to ssh a first time (as root !):
      # ssh -i /run/agenix/rsa_sshfs -o ProxyCommand="ssh -i /run/agenix/rsa_sshfs -q lepageg-ext@access-gricad.univ-grenoble-alpes.fr nc -w 60 cargo 22" lepageg-ext@cargo
      # ssh -i /run/agenix/rsa_sshfs galepage@10.10.10.4

      pathToRsaKey = config.age.secrets.rsa_sshfs.path;
      sshfsOptions = "-fstype=fuse.sshfs,rw,allow_other,IdentityFile=${pathToRsaKey}";

      gricadProxyCommand = "ssh -i ${pathToRsaKey} -q lepageg-ext@access-gricad.univ-grenoble-alpes.fr nc -w 60 cargo 22";

      sshfsMapConf = pkgs.writeText "autofs.mnt.sshfs" ''
        alya \
            ${sshfsOptions} \
            :galepage@10.10.10.4\:/local_scratch/galepage

        gricad \
            ${sshfsOptions},ProxyCommand="${gricadProxyCommand}" \
            :lepageg-ext@cargo\:/bettik/lepageg-ext
      '';
    in ''
      /mnt        ${mapConf}          --timeout 600
      /mnt/sshfs  ${sshfsMapConf}     uid=${uid},gid=${gid},--timeout=60,--ghost
    '';
  };
}

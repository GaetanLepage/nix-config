{pkgs, ...}: {
  services.autofs = {
    enable = true;

    autoMaster = let
      mapConf = pkgs.writeText "autofs.mnt" ''
        alya \
            -fstype=nfs4 \
            10.10.10.4:/galepage

        server \
            -fstype=nfs4 \
            10.10.10.8:/tank

        server_local \
            -fstype=nfs4 \
            192.168.1.100:/tank
      '';
    in ''
      /mnt        ${mapConf}          --timeout 600
    '';
  };
}

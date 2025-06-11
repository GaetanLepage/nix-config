{ pkgs, ... }:
{
  services.autofs = {
    enable = true;

    autoMaster =
      let
        # inria (alya)
        mapConf = pkgs.writeText "autofs.mnt" ''
          alya \
              -fstype=nfs4 \
              10.10.10.4:/galepage

          cuda \
              -fstype=nfs4 \
              10.10.10.5:/home/gaetan

          server \
              -fstype=nfs4 \
              10.10.10.8:/tank

          server_local \
              -fstype=nfs4 \
              192.168.1.100:/tank
        '';
      in
      ''
        /mnt        ${mapConf}          --timeout 600
      '';
  };
}

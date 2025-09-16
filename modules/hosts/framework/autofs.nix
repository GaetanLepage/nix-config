{
  flake.modules.nixos.host_framework =
    { pkgs, ... }:
    {
      services.autofs = {
        enable = true;

        autoMaster =
          let
            mapConf = pkgs.writeText "autofs.mnt" ''
              server \
                  -fstype=nfs4 \
                  10.10.10.8:/tank
            '';
          in
          ''
            /mnt        ${mapConf}          --timeout 600
          '';
      };
    };
}

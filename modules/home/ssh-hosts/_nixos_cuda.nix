{ lib, config, ... }:
{
  programs.ssh.settings =
    let
      User = "root";
      IdentityFile = config.age.secrets.ssh-perso.path;
      domain = "nixos-cuda.org";
    in
    {
      "*.${domain}" = { inherit User IdentityFile; };
    }
    //
      lib.genAttrs
        [
          "hydra"

          "htz1-01"
          "htz1-02"
          "htz1-03"
          "htz1-04"

          "oxi1-01"
          "oxi1-02"
        ]
        (hostname: {
          HostName = "${hostname}.${domain}";
          inherit User IdentityFile;
        });
}

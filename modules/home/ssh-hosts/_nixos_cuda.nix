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
          "ada"
          "atlas"
          "hydra"
          "oxide-1"
          "pascal"
        ]
        (hostname: {
          HostName = "${hostname}.${domain}";
          inherit User IdentityFile;
        });
}

{ lib, config, ... }:
{
  programs.ssh.matchBlocks =
    let
      user = "root";
      identityFile = config.age.secrets.ssh-perso.path;
      domain = "nixos-cuda.org";
    in
    {
      "*.${domain}" = { inherit user identityFile; };
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
          hostname = "${hostname}.${domain}";
          inherit user identityFile;
        });
}

{
  identityFile,
  lib,
}:
lib.mapAttrs
(
  blockName: blockConfig:
    {
      user = "gaetan";
      inherit identityFile;
    }
    // blockConfig
)
{
  ########
  # Home #
  ########

  # coloc
  cuda = {
    hostname = "uc.glepage.com";
    port = 222;
  };
  tv = {
    hostname = "uc.glepage.com";
    port = 223;
    user = "uc";
  };
  router = {
    hostname = "192.168.1.1";
    user = "root";
    extraOptions = {
      HostKeyAlgorithms = "+ssh-rsa";
      PubkeyAcceptedKeyTypes = "+ssh-rsa";
    };
  };
  server.hostname = "uc.glepage.com";

  vps.hostname = "vps.glepage.com";

  pixel = {
    hostname = "10.10.10.3";
    port = 2222;
  };

  ##############
  # Cordineaux #
  ##############
  feroe.hostname = "feroe.glepage.com";

  acl-desktop = {
    hostname = "10.10.10.20";
    user = "root";
  };

  dolibarr = {
    hostname = "dolibarr.lepage-knives.com";
    user = "root";
  };
}

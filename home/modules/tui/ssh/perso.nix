{
  identityFile,
  lib,
}:
lib.mapAttrs
(
  blockName: blockConfig:
    {
      hostname = "glepage.com";
      user = "gaetan";
      inherit identityFile;
    }
    // blockConfig
)
{
  ########
  # Home #
  ########
  cuda.port = 222;

  tv = {
    port = 223;
    user = "uc";
  };

  server = {};
  router = {
    hostname = "192.168.1.1";
    user = "root";
    extraOptions = {
      HostKeyAlgorithms = "+ssh-rsa";
      PubkeyAcceptedKeyTypes = "+ssh-rsa";
    };
  };

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

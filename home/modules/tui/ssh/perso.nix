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

  gaming = {
    port = 223;
    user = "uc";
  };

  server = {};
  router = {
    hostname = "192.168.1.1";
    user = "root";
  };

  pixel = {
    hostname = "10.10.10.3";
    port = 2222;
  };

  ##############
  # Cordineaux #
  ##############
  backup.hostname = "cordineaux.glepage.com";

  acl-desktop = {
    hostname = "10.10.10.20";
    user = "root";
  };
}
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
      hostname = "cuda.glepage.com";
      port = 223;
    };
    router = {
      hostname = "192.168.1.1";
      user = "root";
      extraOptions = {
        HostKeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedKeyTypes = "+ssh-rsa";
      };
    };
    tank = {
      hostname = "tank.glepage.com";
      port = 222;
    };

    vps.hostname = "vps.glepage.com";

    pixel = {
      hostname = "10.10.10.3";
      port = 2222;
    };

    "github.com".user = "git";

    # inria
    chamaeleon = {
      user = "gaetan";
      hostname = "10.10.10.6";
    };

    vps-lepage-knives = {
      host = "lk lepage-knives vps.lepage-knives.com";
      hostname = "vps.lepage-knives.com";
      user = "root";
    };

    ##############
    # Cordineaux #
    ##############
    feroe.hostname = "10.10.10.23";
  }

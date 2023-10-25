{
  identityFile,
  lib,
}:
lib.mapAttrs
(
  blockName: blockConfig:
    {
      user = "galepage";
      inherit identityFile;
    }
    // blockConfig
)
(
  {
    bastion = {
      hostname = "bastion.inrialpes.fr";
    };

    # Generic rule for all Inria computers
    "*.inrialpes.fr" = {
      proxyJump = "alya";
    };

    cluster = {
      hostname = "access2-cp.inrialpes.fr";
      proxyJump = "alya";
    };

    # Workstations
    alya = {
      hostname = "10.10.10.4";
      # hostname = "alya.inrialpes.fr";
      # proxyJump = "bastion";

      setEnv = {
        # Pulse server forwarding
        PULSE_SERVER = "tcp:10.10.10.2:4713";
        TERM = "xterm-256color";
      };
    };
    # auriga = {
    #   hostname = "auriga.inrialpes.fr";
    #   proxyJump = "bastion";
    #   setEnv.TERM = "xterm-256color";
    # };
  }
  // (
    lib.genAttrs
    [
      "auriga"
      "bacchus"
      "pictor"
      "kapelos"
      "ursa"
    ]
    (
      _: {
        proxyJump = "alya";
        setEnv.TERM = "xterm-256color";
      }
    )
  )
)

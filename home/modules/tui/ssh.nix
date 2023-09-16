{config, ...}: let
  ssh_keys_dir = "${config.home.homeDirectory}/config/secrets/ssh/";

  main_key = "${ssh_keys_dir}rsa_tuxedo";
  hes_key = "${ssh_keys_dir}rsa_hes";
in {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*".identityFile = main_key;

      ########
      # Home #
      ########
      cuda = {
        hostname = "glepage.com";
        port = 222;
        user = "gaetan";
      };
      gaming = {
        hostname = "glepage.com";
        port = 223;
        user = "uc";
      };
      server.hostname = "glepage.com";
      router = {
        hostname = "192.168.1.1";
        user = "root";
      };
      oneplus = {
        hostname = "10.10.10.3";
        port = 2222;
      };

      ##############
      # Cordineaux #
      ##############
      backup.hostname = "cordineaux.glepage.com";
      acl-desktop.hostname = "10.10.10.20";

      #########
      # Inria #
      #########
      bastion = {
        hostname = "bastion.inrialpes.fr";
        user = "galepage";
      };

      # Generic rule for all Inria computers
      "*.inrialpes.fr" = {
        user = "galepage";
        proxyJump = "bastion";
      };

      cluster = {
        hostname = "access2-cp.inrialpes.fr";
        user = "galepage";
        proxyJump = "bastion";
      };

      # Workstations
      alya = {
        hostname = "10.10.10.4";
        # hostname = "alya.inrialpes.fr";
        user = "galepage";
        # proxyJump = "bastion";

        # Pulse server forwarding
        setEnv = {
          PULSE_SERVER = "tcp:10.10.10.2:4713";
          TERM = "xterm-256color";
        };
      };
      auriga = {
        hostname = "auriga.inrialpes.fr";
        user = "galepage";
        proxyJump = "bastion";
        setEnv.TERM = "xterm-256color";
      };

      ##########
      # GriCAD #
      ##########
      "bigfoot" = {
        user = "lepageg-ext";
        proxyCommand = "ssh -q lepageg-ext@access-gricad.univ-grenoble-alpes.fr 'nc -w 60 bigfoot %p'";
      };

      "cargo" = {
        user = "lepageg-ext";
        proxyCommand = "ssh -q lepageg-ext@access-gricad.univ-grenoble-alpes.fr 'nc -w 60 cargo %p'";
      };

      ############
      # Jean Zay #
      ############
      "jz*" = {
        hostname = "jean-zay.idris.fr";
        user = "uzp33qu";
      };

      jza.proxyJump = "alya";

      ##########
      # HES-SO #
      ##########
      faster = {
        hostname = "faster.hevs.ch";
        user = "gaetan";
        identityFile = hes_key;
        forwardAgent = false;
      };

      ultrafast = {
        hostname = "153.109.124.39";
        user = "gaetan";
        identityFile = hes_key;
        proxyJump = "faster";
        forwardAgent = false;
      };
    };
  };

  home.shellAliases = {
    s = "ssh";
    sa = "ssh alya";
    sam = "ssh alya -t tmux attach-session -t hm";
    si = "ssh -J bastion -l galepage";
    sc = "ssh cuda";
  };
}

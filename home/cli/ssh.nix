{ config, ... }:

let
    main_key =  "${config.home.homeDirectory}/dotfiles/secrets/ssh/rsa";
    hes_key =  "${config.home.homeDirectory}/dotfiles/secrets/ssh/rsa_hes";

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
            backup.hostname = "cordineaux.glepage.com";
            router = {
                hostname = "192.168.1.1";
                user = "root";
            };
            oneplus = {
                hostname = "10.10.10.3";
                port = 2222;
            };

            #########
            # Inria #
            #########
            bastion = {
                hostname = "bastion.inrialpes.fr";
                user = "galepage";
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
            };
            auriga = {
                hostname = "auriga.inrialpes.fr";
                user = "galepage";
                proxyJump = "bastion";
            };

            ##########
            # GriCAD #
            ##########
            "*.ciment" = {
              user = "lepageg-ext";
              proxyCommand = "ssh -q lepageg-ext@access-gricad.univ-grenoble-alpes.fr 'nc -w 60 `basename %h .ciment` %p'";
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

            ###########
            # Ensimag #
            ###########
            ensimag = {
                host = "pcserveur.ensimag.frj";
                user = "lepageg";
            };
        };
    };

    # TODO ssh-agent when on a CLI environment (ex: alya)

    home.shellAliases = {
        sa      = "ssh alya";
        sam     = "ssh alya -t tmux attach-session -t hm";
        sshi    = "ssh -J bastion -l galepage";
    };
}




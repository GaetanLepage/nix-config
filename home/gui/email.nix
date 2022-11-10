{ lib, ... }:
{
    programs.thunderbird = {
        enable = true;

        profiles.default = {
            isDefault = true;
        };
    };

    accounts.email.accounts = lib.mapAttrs (

        name: config: {
            realName = "Gaetan Lepage";
            userName = config.address;

            thunderbird.enable = true;
        } // config

    ) {

        perso = {
            address = "gaetan@glepage.com";

            primary = true;

            imap = {
                host = "glepage.com";
                port = 143;
                tls.useStartTls = true;
            };

            smtp = {
                host = "glepage.com";
                port = 587;
                tls.useStartTls = true;
            };
        };

        inria = {
            address = "gaetan.lepage@inria.fr";
            userName = "galepage";

            imap = {
                host = "zimbra.inria.fr";
                port = 993;
            };

            smtp = {
                host = "smtp.inria.fr";
                port = 587;
                tls.useStartTls = true;
            };
        };

        inp-fr = {
            address = "gaetan.lepage@grenoble-inp.fr";
            userName = "gaetan.lepage";

            imap = {
                host = "imap.grenoble-inp.fr";
                port = 993;
            };

            smtp = {
                host = "smtp.grenoble-inp.fr";
                port = 587;
                tls.useStartTls = true;
            };
        };

        inp-org = {
            address = "gaetan.lepage@grenoble-inp.org";

            imap = {
                host = "imap.partage.renater.fr";
                port = 993;
            };

            smtp = {
                host = "smtp.partage.renater.fr";
                port = 465;
            };
        };

        gmx = {
            address = "g.lepage@gmx.com";

            imap = {
                host = "imap.gmx.com";
                port = 993;
            };

            smtp = {
                host = "mail.gmx.com";
                port = 465;
            };
        };

        gmail = {
            address = "gaetan.lepage00@gmail.com";
            flavor = "gmail.com";
        };

        hotmail = {
            address = "gaetlep@hotmail.fr";
            flavor = "outlook.office365.com";
        };

        lepage-knives = {
            address = "glepage@lepage-knives.com";

            imap = {
                host = "imap.ionos.fr";
                port = 143;
                tls.useStartTls = true;
            };

            smtp = {
                host = "smtp.ionos.fr";
                port = 465;
            };
        };
    };
}

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

            thunderbird = {
                enable = true;
                settings = id: {
                    "mail.identity.id_${id}.reply_on_top" = 1;
                    "mail.identity.id_${id}.sig_bottom" = false;
                };
            };
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
    };
}

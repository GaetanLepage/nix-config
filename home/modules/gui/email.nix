{lib, ...}: {
  programs.thunderbird = {
    enable = true;

    profiles.default = {
      isDefault = true;
    };
  };

  accounts.email.accounts =
    lib.mapAttrs (
      _: config:
        {
          realName = "Gaetan Lepage";
          userName = config.address;

          thunderbird = {
            enable = true;
            settings = id: {
              "mail.identity.id_${id}.reply_on_top" = 1;
              "mail.identity.id_${id}.sig_bottom" = false;
              # Sorting
              "mailnews.default_sort_order" = 2; # descending
              "mailnews.default_sort_type" = 18; # by date
              # Disable telemetry
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.rejected" = true;
              "toolkit.telemetry.prompted" = 2;
            };
          };
        }
        // config
    ) {
      perso = {
        address = "gaetan@glepage.com";

        primary = true;

        imap = {
          host = "mail.glepage.com";
          port = 143;
          tls.useStartTls = true;
        };

        smtp = {
          host = "mail.glepage.com";
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

      hotmail = {
        address = "gaetlep@hotmail.fr";
        flavor = "outlook.office365.com";
      };

      uga = {
        address = "gaetan.lepage@univ-grenoble-alpes.fr";

        imap = {
          host = "zimbra.univ-grenoble-alpes.fr";
          port = 993;
        };

        smtp = {
          host = "smtps.univ-grenoble-alpes.fr";
          port = 587;
          tls.useStartTls = true;
        };
      };
    };
}

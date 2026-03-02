{
  flake.modules.homeManager.email =
    { lib, ... }:
    {
      programs.thunderbird = {
        enable = true;

        profiles.default = {
          isDefault = true;
        };
      };

      accounts.email.accounts =
        let
          applyDefaults =
            config:
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
            // config;

          # Defaults for all of my @glepage.com accounts
          glepageDefaults = {
            imap = {
              host = "mail.glepage.com";
              port = 993;
            };

            smtp = {
              host = "mail.glepage.com";
              port = 465;
            };
          };
        in
        lib.mapAttrs (_: applyDefaults) {
          perso = {
            address = "gaetan@glepage.com";

            primary = true;
          }
          // glepageDefaults;

          dev = {
            address = "dev@glepage.com";
          }
          // glepageDefaults;

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
        };
    };
}

{ config, ... }:
{
  services = {
    nextcloud.config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
    };

    postgresql =
      let
        inherit (config.services.nextcloud.config) dbname dbuser;
      in
      {
        enable = true;
        ensureDatabases = [ dbname ];
        ensureUsers = [
          {
            name = dbuser;
            ensureDBOwnership = true;
          }
        ];

        settings = {
          # From Nextcloud:
          #   A significant share of page reads are missing the shared buffer cache.
          #   Cache hit ratio is 76.95%; aim for 99% or higher.
          #   Increase shared_buffers (a common starting point is 25 % of system RAM).
          shared_buffers = "256MB";
        };
      };
  };
}

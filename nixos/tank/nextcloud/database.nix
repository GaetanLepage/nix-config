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
      };
  };
}

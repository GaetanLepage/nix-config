let
  domain = "notes.glepage.com";
  port = 1780;

  databaseName = "hedgedoc";
in
{
  services = {
    caddy.reverseProxies.${domain}.port = port;

    # Database
    postgresql = {
      ensureDatabases = [ databaseName ];
      ensureUsers = [
        {
          name = databaseName;
          ensureDBOwnership = true;
        }
      ];
    };

    hedgedoc = {
      enable = true;

      settings = {
        inherit domain;
        inherit port;

        # This variable won't activate encryption on the listen port.
        # Set this to true if your reverse proxy exposes your instance via HTTPS.
        protocolUseSSL = true;

        defaultPermission = "private";

        # Set to allow registration of new accounts using an email address.
        # If set to false, you can still create accounts using the command line - see
        # `bin/manage_users` for details (In production mode, remember to run it with `NODE_ENV` set
        # as production in the enviroment).
        # This setting has no effect if `settings.email` is false.
        allowEmailRegister = false;

        db = {
          dialect = "postgres";
          host = "/run/postgresql";
          database = databaseName;
          username = databaseName;
        };
      };
    };
  };
}

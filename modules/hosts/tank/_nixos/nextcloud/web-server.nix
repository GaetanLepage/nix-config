{ config, ... }:
let
  inherit (config.services.nextcloud) hostName;
in
{
  users.groups.nextcloud.members = [
    config.services.caddy.user
  ];

  services = {
    ##############
    # Web server #
    ##############

    # Using caddy --> We have to manually disable nginx.
    nginx.enable = false;

    phpfpm.pools.nextcloud.settings = {
      "listen.owner" = config.services.caddy.user;
      "listen.group" = config.services.caddy.group;
    };

    # Source: https://github.com/onny/nixos-nextcloud-testumgebung/blob/main/nextcloud-extras.nix#L117-L167
    caddy.virtualHosts.${hostName} =
      let
        webroot = config.services.nginx.virtualHosts.${hostName}.root;
      in
      {
        extraConfig = ''
          encode zstd gzip

          root * ${webroot}

          redir /.well-known/carddav /remote.php/dav 301
          redir /.well-known/caldav /remote.php/dav 301
          redir /.well-known/* /index.php{uri} 301
          redir /remote/* /remote.php{uri} 301

          header {
              Strict-Transport-Security max-age=31536000
              Permissions-Policy interest-cohort=()
              X-Content-Type-Options nosniff
              X-Frame-Options SAMEORIGIN
              Referrer-Policy no-referrer
              X-XSS-Protection "1; mode=block"
              X-Permitted-Cross-Domain-Policies none
              X-Robots-Tag "noindex, nofollow"
              -X-Powered-By
          }

          php_fastcgi unix/${config.services.phpfpm.pools.nextcloud.socket} {
              root ${webroot}
              env front_controller_active true
              env modHeadersAvailable true
          }

          @forbidden {
              path /build/* /tests/* /config/* /lib/* /3rdparty/* /templates/* /data/*
              path /.* /autotest* /occ* /issue* /indie* /db_* /console*
              not path /.well-known/*
          }
          error @forbidden 404

          @immutable {
              path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
              query v=*
          }
          header @immutable Cache-Control "max-age=15778463, immutable"

          @static {
              path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
              not query v=*
          }
          header @static Cache-Control "max-age=15778463"

          @woff2 path *.woff2
          header @woff2 Cache-Control "max-age=604800"

          file_server
        '';
      };
  };
}

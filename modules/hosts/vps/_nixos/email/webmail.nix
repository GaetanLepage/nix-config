{
  config,
  pkgs,
  lib,
  ...
}:
{
  services =
    let
      hostName = "webmail.glepage.com";
    in
    {
      nginx.enable = lib.mkForce false;
      caddy.virtualHosts.${hostName}.extraConfig = ''
        root * ${config.services.roundcube.package}
        file_server

        php_fastcgi unix/${config.services.phpfpm.pools.roundcube.socket}
      '';

      phpfpm.pools.roundcube.settings = {
        "listen.owner" = config.services.caddy.user;
        "listen.group" = config.services.caddy.group;
      };

      roundcube = {
        enable = true;

        # List of aspell dictionaries for spell checking. If empty, spell checking is disabled.
        dicts = with pkgs.aspellDicts; [
          en
          fr
        ];

        inherit hostName;

        extraConfig = ''
          // IMAP
          $config['imap_host'] = 'ssl://${config.mailserver.fqdn}';
          $config['imap_conn_options'] = array(
              'ssl' => array(
                  'verify_peer' => false,
                  'verify_peer_name' => false,
              ),
          );

          // SMTP
          $config['smtp_host'] = 'ssl://${config.mailserver.fqdn}:465';
          $config['smtp_conn_options'] = array(
              'ssl' => array(
                  'verify_peer' => false,
                  'verify_peer_name' => false,
              ),
          );
          $config['smtp_user'] = '%u';
          $config['smtp_pass'] = '%p';
        '';
      };
    };
}

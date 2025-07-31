{ config, ... }:
{
  services = {
    caddy.reverseProxies."photos.glepage.com".port = config.services.immich.port;

    immich = {
      enable = true;
    };
  };
}

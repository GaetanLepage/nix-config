{ config, ... }:
{
  services = {
    caddy.reverseProxies."photos.glepage.com".port = config.services.immich.port;

    immich = {
      # TODO: albumentations is broken
      enable = false;
    };
  };
}

{
  lib,
  config,
  ...
}:
{
  services = {
    caddy.reverseProxies."paste.glepage.com".port =
      lib.toInt config.services.microbin.settings.MICROBIN_PORT;

    microbin = {
      enable = true;
      settings = {
        MICROBIN_ETERNAL_PASTA = true;
      };
    };
  };
}

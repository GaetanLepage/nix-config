{
  lib,
  config,
  ...
}:
{
  age.secrets.microbin-password.rekeyFile = ./password.age;

  services = {
    caddy.reverseProxies."paste.glepage.com".port =
      lib.toInt config.services.microbin.settings.MICROBIN_PORT;

    microbin = {
      enable = true;

      passwordFile = config.age.secrets.microbin-password.path;

      settings = {
        MICROBIN_ETERNAL_PASTA = true;
      };
    };
  };
}

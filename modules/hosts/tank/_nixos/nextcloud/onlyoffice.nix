{ config, ... }:
let
  domain = "onlyoffice.glepage.com";
  port = 1680;
in
{
  services = {
    caddy.reverseProxies.${domain}.port = port;

    nextcloud.settings.onlyoffice.DocumentServerUrl = domain;
  };

  age.secrets.onlyoffice-env-file.rekeyFile = ./onlyoffice-env-file.age;

  virtualisation = {
    podman.enable = true;

    oci-containers.containers.only-office = {
      image = "onlyoffice/documentserver";
      ports = [ "${toString port}:80" ];
      # Disable token authentication because it is annoying...
      environment.JWT_ENABLED = "true";
      environmentFiles = [
        # Contains `JWT_SECRET=<token>`
        config.age.secrets.onlyoffice-env-file.path
      ];
    };
  };
}

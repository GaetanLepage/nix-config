{ config, ... }:
let
  companionPort = "8282";
in
{
  age.secrets.invidious-companion-secret.rekeyFile = ./companion-secret.age;

  services.invidious.settings = {
    invidious_companion = [
      {
        private_url = "http://localhost:${companionPort}/companion";
      }
    ];
  };

  virtualisation = {
    podman.enable = true;

    # To update the image:
    # sudo podman pull quay.io/invidious/invidious-companion:latest
    # sudo systemctl restart podman-invidious-companion.service
    oci-containers = {
      backend = "podman";
      containers.invidious-companion = {
        image = "quay.io/invidious/invidious-companion:latest";
        ports = [ "127.0.0.1:8282:${companionPort}" ];
        volumes = [
          "companioncache:/var/tmp/youtubei.js:rw"
        ];
        environmentFiles = [
          config.age.secrets.invidious-companion-secret.path
        ];
      };
    };
  };
}

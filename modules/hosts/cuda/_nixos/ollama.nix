{ config, ... }:
{
  services = {
    ollama = {
      enable = true;
      host = "localhost";
      loadModels = [
        "mistral-nemo"
      ];
    };

    open-webui = {
      # TODO (2026-05-25) open-webui-frontend is broken
      enable = false;

      openFirewall = true;
      host = "0.0.0.0";

      environment = {
        OLLAMA_API_BASE_URL = "http://127.0.0.1:${toString config.services.ollama.port}";
      };
    };
  };
}

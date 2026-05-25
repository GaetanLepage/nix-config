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
      enable = true;

      openFirewall = true;
      host = "0.0.0.0";

      environment = {
        OLLAMA_API_BASE_URL = "http://127.0.0.1:${toString config.services.ollama.port}";
      };
    };
  };
}

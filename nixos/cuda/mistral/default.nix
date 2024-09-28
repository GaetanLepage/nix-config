{
  imports = [
    ./module.nix
  ];

  services.open-webui = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      WEBUI_AUTH = "False";
      OPENAI_API_BASE_URL = "http://localhost:1234/v1";
      ENABLE_OLLAMA_API = "False";
      PYDANTIC_SKIP_VALIDATING_CORE_SCHEMAS = "True";
    };
  };

  services.mistral-rs = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
    extraFlags = [
      "--token-source"
      "path:/tmp/token"
    ];
    extraCommandFlags = [
      "--model-id"
      "mistralai/Mistral-7B-Instruct-v0.3"
      "--arch"
      "mistral"
    ];
    user = "mistral-rs";
  };
}

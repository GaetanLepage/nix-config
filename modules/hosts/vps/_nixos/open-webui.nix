let
  domain = "chat.glepage.com";
  port = 1880;
in
{
  services = {
    caddy.reverseProxies.${domain} = {
      inherit port;
      vpn = false;
    };

    open-webui = {
      enable = true;

      inherit port;

      environment = {
        # Setting `environment` replaces the module default wholesale, so the telemetry opt-outs
        # have to be repeated here.
        SCARF_NO_ANALYTICS = "True";
        DO_NOT_TRACK = "True";
        ANONYMIZED_TELEMETRY = "False";

        WEBUI_URL = "https://${domain}";

        # llama-server exposes an OpenAI-compatible API, so it is configured as a plain OpenAI
        # provider and advertises its `--alias` as the model name.
        ENABLE_OLLAMA_API = "False";

        # spark's wireguard address, see `modules/hosts/spark/_nixos/llama-cpp.nix`.
        OPENAI_API_BASE_URL = "http://10.10.10.9:8080/v1";

        # Unauthenticated, but open-webui insists on a non-empty value.
        OPENAI_API_KEY = "unused";
      };
    };
  };
}

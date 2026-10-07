{
  # Public OpenAI-compatible endpoint for llama-server on spark, reached over wireguard.
  # Authentication is done by llama-server itself (API keys), see
  # `modules/hosts/spark/_nixos/llama-cpp.nix`.
  #
  # Only `/v1/*` is forwarded: llama-server also serves a web UI and a few other routes
  # (`/health`, `/props`, ...) that do not require a key.
  services.caddy.virtualHosts."llm.glepage.com".extraConfig = ''
    handle /v1/* {
        reverse_proxy 10.10.10.9:8080
    }

    handle {
        respond 404
    }
  '';
}

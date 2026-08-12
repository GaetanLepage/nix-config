{ config, ... }:
{
  services = {
    llama-cpp = {
      enable = true;

      settings = {
        # wg0 address, so the server is only reachable over wireguard.
        host = "10.10.10.9";
        port = 8080;

        # 117B total / 5.1B active MoE, shipped natively in MXFP4 (no quantization loss).
        # ~63 GB, downloaded to /var/cache/llama-cpp on first start.
        hf-repo = "ggml-org/gpt-oss-120b-GGUF:MXFP4";
        alias = "gpt-oss-120b";

        ctx-size = 131072;

        # Both measurably matter on GB10:
        # https://github.com/ggml-org/llama.cpp/discussions/16578
        flash-attn = "on";
        batch-size = 2048;
        ubatch-size = 2048;

        # EAGLE-3 speculative decoding, using the draft model shipped in the same
        # repo. Untested on GB10, should help token generation.
        # hf-repo-draft = "ggml-org/gpt-oss-120b-GGUF:Q8_0";
        # spec-type = "draft-eagle3";
      };
    };
  };

  networking.firewall.interfaces.wg0.allowedTCPPorts = [
    config.services.llama-cpp.settings.port
  ];

  # The upstream unit is only ordered after `network.target`, which does not
  # guarantee that wg0 holds its address yet. Binding would then fail with
  # EADDRNOTAVAIL, and `RestartSec = 300` makes a lost race expensive.
  systemd.services.llama-cpp = {
    wants = [ "wireguard-wg0.service" ];
    after = [ "wireguard-wg0.service" ];
  };
}

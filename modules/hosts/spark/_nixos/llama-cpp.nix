{ config, ... }:
{
  services = {
    llama-cpp = {
      enable = true;

      settings = {
        # wg0 address, so the server is only reachable over wireguard.
        host = "10.10.10.9";
        port = 8080;

        # Poolside Laguna S 2.1: 118B total / 8.5B active MoE, code/agent-focused.
        # Supported upstream since ggml-org/llama.cpp#25165 and #26233.
        # unsloth's UD-Q4_K_XL is ~73 GB. Poolside's own Q4_K_M is 96 GB despite its README
        # saying 68 GB, which leaves too little of the ~120 GB usable memory on GB10.
        # Downloaded to /var/cache/llama-cpp on first start.
        hf-repo = "unsloth/Laguna-S-2.1-GGUF:UD-Q4_K_XL";
        alias = "laguna-s-2.1";

        # Only 1 in 4 layers is full attention (the rest use a 512-token sliding window), so
        # the f16 KV cache costs ~48 KB/token: ~13 GB at the 256K the GGUFs are tuned for.
        ctx-size = 262144;

        # Sampling defaults from the model's generation_config.json.
        temp = 1.0;
        top-p = 1.0;
        top-k = 20;
        min-p = 0.0;

        # Both measurably matter on GB10:
        # https://github.com/ggml-org/llama.cpp/discussions/16578
        flash-attn = "on";
        batch-size = 2048;
        ubatch-size = 2048;

        # No speculative decoding: Poolside's DFlash drafter (`laguna-s-2.1-DFlash-BF16.gguf`)
        # only loads with their llama.cpp fork. Upstream fails with
        # "wrong number of tensors; expected 76, got 69".
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

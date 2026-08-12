{ lib, ... }:
{
  programs.opencode = {
    enable = true;

    settings = {
      model = lib.mkDefault "anthropic/claude-opus-4-6";

      # llama-server on spark, reached over wireguard.
      # See `modules/hosts/spark/_nixos/llama-cpp.nix`.
      provider.spark = {
        npm = "@ai-sdk/openai-compatible";
        name = "spark (llama.cpp)";

        options.baseURL = "http://10.10.10.9:8080/v1";

        # Keys have to match the `id` served by /v1/models, which llama-server
        # takes from its `--alias`.
        models.gpt-oss-120b = {
          name = "gpt-oss-120b";
          limit = {
            context = 131072;
            output = 32768;
          };
        };
      };

      permission = {
        external_directory = {
          # /nix/store entries are world-readable (RO) anyway
          "/nix/store" = "allow";
        };
      };
    };
  };

  home.shellAliases.oc = "opencode";
}

{ lib, ... }:
{
  programs.opencode = {
    enable = true;

    settings = {
      model = lib.mkDefault "mistral/zai-glm-5-3";

      # llama-server on spark, reached over wireguard.
      # See `modules/hosts/spark/_nixos/llama-cpp.nix`.
      provider.spark = {
        npm = "@ai-sdk/openai-compatible";
        name = "spark (llama.cpp)";

        options.baseURL = "http://10.10.10.9:8080/v1";

        # Keys have to match the `id` served by /v1/models, which llama-server
        # takes from its `--alias`.
        models."laguna-s-2.1" = {
          name = "laguna-s-2.1";
          limit = {
            context = 262144;
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

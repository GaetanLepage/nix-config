{ lib, ... }:
{
  programs.opencode = {
    enable = true;

    settings = {
      model = lib.mkDefault "openai/gpt-5.3-codex";
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
